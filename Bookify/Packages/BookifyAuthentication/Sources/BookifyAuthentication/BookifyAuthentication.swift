import Foundation
import BookifySharedSystem
import AuthenticationServices
import CryptoKit
import Security

public final class BookifyAuthentication: NSObject {

    // MARK: Shared
    public static let shared = BookifyAuthentication()
    private override init() { super.init() }

    // MARK: Config / State
    private var config: BookifyAuthConfig?
    private var session: ASWebAuthenticationSession?
    private var pkce: ProofKeyCodeExchange?
    private var pendingContinuation: CheckedContinuation<URL, Error>?

    // Cache the current token (also persisted in Keychain)
    private let tokenStore = KeychainStore<BookifyTokenPair>(
        service: "com.bookify.auth",
        account: "tokenpair"
    )

    private var current: BookifyTokenPair? {
        get { try? tokenStore.load() }
        set {
            if let token = newValue {
                try? tokenStore.save(token)
            } else {
                try? tokenStore.clear()
            }
        }
    }
    // MARK: Public API

    /// Call once at app start.
    public func configure(_ config: BookifyAuthConfig) {
        self.config = config
    }

    /// Starts OAuth 2.0 Authorization Code (PKCE) sign-in using system browser.
    @MainActor
    public func signIn() async throws -> BookifyTokenPair {
        guard let cfg = config else { throw BookifyAuthError.notConfigured }
        let pkce = ProofKeyCodeExchange.generate()
        self.pkce = pkce

        // Build /authorize request
        var comps = URLComponents(url: cfg.authorizeURL, resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            .init(name: "response_type", value: "code"),
            .init(name: "client_id", value: cfg.clientId),
            .init(name: "redirect_uri", value: cfg.redirectURI),
            .init(name: "scope", value: cfg.scopes),
            .init(name: "code_challenge", value: pkce.challenge),
            .init(name: "code_challenge_method", value: "S256"),
            .init(name: "state", value: UUID().uuidString)
        ]

        // Open system browser and await callback
        let callback = try await startSession(
            authURL: comps.url!,
            callbackScheme: cfg.redirectScheme,
            prefersEphemeral: cfg.prefersEphemeral
        )

        // Extract code
        guard
            let items = URLComponents(url: callback, resolvingAgainstBaseURL: false)?.queryItems,
            let code = items.first(where: { $0.name == "code" })?.value
        else { throw BookifyAuthError.codeMissing }

        // Exchange code for tokens
        let pair = try await exchangeCodeForTokens(code: code,
                                                   verifier: pkce.verifier,
                                                   cfg: cfg)
        current = pair
        return pair
    }

    /// Clears tokens from Keychain (local logout). For full logout, also hit your IdP's revoke endpoint.
    public func signOut() {
        current = nil
    }

    /// Returns an "Authorization: Bearer xxx" header if available; refreshes if needed.
    public func authorizationHeader() async throws -> String? {
        guard var token = current else { return nil }
        if token.isExpiringSoon {
            token = try await refresh()
            current = token
        }
        return "Bearer \(token.accessToken)"
    }

    /// Convenience: attaches the header if available.
    public func attachAuthHeader(to request: inout URLRequest) async {
        if let h = try? await authorizationHeader() {
            request.setValue(h, forHTTPHeaderField: "Authorization")
        }
    }

    /// Must be called from SceneDelegate (or UIApplicationDelegate for UIScene-less apps) on URL open.
    public func handleOpenURL(_ url: URL) {
        pendingContinuation?.resume(returning: url)
        pendingContinuation = nil
        session = nil
    }
}

private extension BookifyAuthentication {
    @MainActor
    func startSession(
        authURL: URL,
        callbackScheme: String,
        prefersEphemeral: Bool
    ) async throws -> URL {
        try await withCheckedThrowingContinuation { (cont: CheckedContinuation<URL, Error>) in
            pendingContinuation = cont
            
            let s = ASWebAuthenticationSession(url: authURL, callbackURLScheme: callbackScheme) { [weak self] url, err in
                defer { self?.session = nil; self?.pendingContinuation = nil }
                if let url { cont.resume(returning: url) }
                else { cont.resume(throwing: err ?? BookifyAuthError.cancelled) }
            }
            s.presentationContextProvider = self
            s.prefersEphemeralWebBrowserSession = prefersEphemeral
            self.session = s
            _ = s.start()
        }
    }
    
    func exchangeCodeForTokens(
        code: String,
        verifier: String,
        cfg: BookifyAuthConfig
    ) async throws -> BookifyTokenPair {
        var req = URLRequest(url: cfg.tokenURL)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpBody = formURLEncoded([
            "grant_type": "authorization_code",
            "code": code,
            "client_id": cfg.clientId,
            "redirect_uri": cfg.redirectURI,
            "code_verifier": verifier
        ])
        
        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode)
        else { throw BookifyAuthError.badHTTPStatus((resp as? HTTPURLResponse)?.statusCode ?? -1) }
        
        return try decodeTokenPair(data)
    }
    
    @discardableResult
    func refresh() async throws -> BookifyTokenPair {
        guard let cfg = config else { throw BookifyAuthError.notConfigured }
        guard let old = current else { throw BookifyAuthError.tokenUnavailable }
        guard let refresh = old.refreshToken else { throw BookifyAuthError.refreshUnavailable }
        
        var req = URLRequest(url: cfg.tokenURL)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpBody = formURLEncoded([
            "grant_type": "refresh_token",
            "refresh_token": refresh,
            "client_id": cfg.clientId
        ])
        
        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200...299).contains(http.statusCode)
        else { throw BookifyAuthError.badHTTPStatus((resp as? HTTPURLResponse)?.statusCode ?? -1) }
        
        let newPair = try decodeTokenPair(data, fallbackRefresh: refresh)
        current = newPair
        return newPair
    }
    
    func decodeTokenPair(_ data: Data, fallbackRefresh: String? = nil) throws -> BookifyTokenPair {
        // Common token endpoint fields
        struct DTO: Decodable {
            let access_token: String
            let refresh_token: String?
            let id_token: String?
            let expires_in: Int
            let token_type: String?
        }
        guard let dto = try? JSONDecoder().decode(DTO.self, from: data) else {
            throw BookifyAuthError.decodingFailed
        }
        let expiry = Date().addingTimeInterval(TimeInterval(dto.expires_in))
        return BookifyTokenPair(
            accessToken: dto.access_token,
            refreshToken: dto.refresh_token ?? fallbackRefresh,
            idToken: dto.id_token,
            expiresAt: expiry,
            tokenType: (dto.token_type ?? "Bearer")
        )
    }
    
    func formURLEncoded(_ dict: [String: String]) -> Data? {
        dict.map { key, value in
            let v = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "\(key)=\(v)"
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

// MARK: - ASWebAuthenticationPresentationContextProviding
extension BookifyAuthentication: ASWebAuthenticationPresentationContextProviding {
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first ?? ASPresentationAnchor()
    }
}

