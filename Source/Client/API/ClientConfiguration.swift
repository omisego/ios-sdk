//
//  ClientConfiguration.swift
//  OmiseGO
//
//  Created by Mederic Petit on 7/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// Represents a configuration object used to setup an HTTPClient
public struct ClientConfiguration: Configuration {
    /// The current SDK version
    public let apiVersion: String = "1"

    /// The base URL of the wallet server:
    /// When initializing the HTTPClient, this needs to be an http(s) url
    /// When initializing the SocketClient, this needs to be a ws(s) url
    public let baseURL: String
    public var credentials: Credential
    public let debugLog: Bool

    /// Creates the configuration required to initialize the OmiseGO SDK
    ///
    /// - Parameters:
    ///   - baseURL: The base URL of the wallet server
    ///              When initializing the HTTPClient, this needs to be an http(s) url
    ///              When initializing the SocketClient, this needs to be a ws(s) url
    ///   - apiKey: The API key (typically generated on the admin panel)
    ///   - authenticationToken: The authentication token of the current user
    ///   - debugLog: Enable or not SDK console logs
    public init(baseURL: String, credentials: ClientCredential, debugLog: Bool = false) {
        self.baseURL = baseURL + "/api/client"
        self.credentials = credentials
        self.debugLog = debugLog
    }
}