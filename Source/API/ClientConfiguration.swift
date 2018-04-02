//
//  ClientConfiguration.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// Represents a configuration object used to setup an HTTPClient
public struct ClientConfiguration {

    /// The current SDK version
    public let apiVersion: String = "1"

    /// The base URL of the wallet server:
    /// When initializing the HTTPClient, this needs to be an http(s) url
    /// When initializing the SocketClient, this needs to be a ws(s) url
    public let baseURL: String
    /// The API key (typically generated on the admin panel)
    public let apiKey: String
    /// The authentication token of the current user
    public var authenticationToken: String?

    /// Creates the configuration required to initialize the OmiseGO SDK
    ///
    /// - Parameters:
    ///   - baseURL: The base URL of the wallet server
    ///              When initializing the HTTPClient, this needs to be an http(s) url
    ///              When initializing the SocketClient, this needs to be a ws(s) url
    ///   - apiKey: The API key (typically generated on the admin panel)
    ///   - authenticationToken: The authentication token of the current user
    public init(baseURL: String, apiKey: String, authenticationToken: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.authenticationToken = authenticationToken
    }

}
