//
//  BookifyAuthConfig.swift
//  BookifyAuthentication
//
//  Created by radha chilamkurthy on 08/11/25.
//

import Foundation

public struct BookifyAuthConfig: Sendable {
    public let authorizeURL: URL
    public let tokenURL: URL
    public let clientId: String
    public let redirectScheme: String         // e.g. "bookify"
    public let redirectURI: String            // e.g. "bookify://auth/callback"
    public let scopes: String                 // e.g. "openid profile email offline_access"
    public let prefersEphemeral: Bool         // SSO or ephemeral session

    public init(
        authorizeURL: URL,
        tokenURL: URL,
        clientId: String,
        redirectScheme: String,
        redirectURI: String,
        scopes: String = "openid profile email offline_access",
        prefersEphemeral: Bool = true
    ) {
        self.authorizeURL = authorizeURL
        self.tokenURL = tokenURL
        self.clientId = clientId
        self.redirectScheme = redirectScheme
        self.redirectURI = redirectURI
        self.scopes = scopes
        self.prefersEphemeral = prefersEphemeral
    }
}
