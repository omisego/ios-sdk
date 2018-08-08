//
//  ClientCredential.swift
//  OmiseGO
//
//  Created by Mederic Petit on 7/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

public struct ClientCredential: Credential {
    public let apiKey: String
    public var authenticationToken: String?

    public init(apiKey: String, authenticationToken: String) {
        self.apiKey = apiKey
        self.authenticationToken = authenticationToken
    }

    public func authentication() throws -> String? {
        guard let authenticationToken = self.authenticationToken else {
            throw OMGError.configuration(message: "Authentication token is required")
        }
        return try CredentialEncoder.encode(value1: self.apiKey, value2: authenticationToken, scheme: "OMGClient")
    }

    public mutating func invalidate() {
        self.authenticationToken = nil
    }
}
