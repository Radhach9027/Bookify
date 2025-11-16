//
//  ProofKeyCodeExchange.swift
//  BookifyAuthentication
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation
import CryptoKit

struct ProofKeyCodeExchange {
    let verifier: String
    let challenge: String

    static func generate() -> ProofKeyCodeExchange {
        let verifier = randomURLSafe(length: 64)
        let challenge = codeChallenge(from: verifier)
        return ProofKeyCodeExchange(verifier: verifier, challenge: challenge)
    }

    private static func codeChallenge(from verifier: String) -> String {
        let hash = SHA256.hash(data: Data(verifier.utf8))
        return Data(hash).base64URLEncodedString()
    }

    private static func randomURLSafe(length: Int) -> String {
        var bytes = [UInt8](repeating: 0, count: length)
        _ = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        return Data(bytes).base64URLEncodedString()
    }
}

private extension Data {
    func base64URLEncodedString() -> String {
        self.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
