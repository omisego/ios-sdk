//
//  LiveClientTestCase.swift
//  Tests
//
//  Created by Mederic Petit on 18/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import Foundation
import OmiseGO
import XCTest

class LiveClientTestCase: XCTestCase {
    private static let OMG_BASE_URL = "OMG_BASE_URL"
    private static let OMG_WEBSOCKET_URL = "OMG_WEBSOCKET_URL"
    private static let OMG_API_KEY = "OMG_API_KEY"
    private static let OMG_AUTHENTICATION_TOKEN = "OMG_AUTHENTICATION_TOKEN"
    private static let OMG_TOKEN_ID = "OMG_TOKEN_ID"

    var validWebsocketURL: String = ""
    var validBaseURL: String = ""
    var validAPIKey: String = ""
    var validAuthenticationToken: String = ""
    var validTokenId: String = ""

    let invalidWebsocketURL = "an invalid websocket url"
    let invalidBaseURL = "an invalid base url"
    let invalidAPIKey = "an invalid api key"
    let invalidAuthenticationToken = "an invalid authentication token"

    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        self.loadEnvKeys()
        if !self.areKeysValid() {
            XCTFail("""
                Missing values for required constants.
                Replace them in secret.plist or pass them as environment variables.
            """)
        }
        self.testClient = HTTPClient(config: self.validHTTPConfig())
        self.testSocketClient = SocketClient(config: self.validSocketConfig(), delegate: nil)
    }

    var testClient: HTTPClient!
    var testSocketClient: SocketClient!

    private func validHTTPConfig() -> ClientConfiguration {
        let credentials = ClientCredential(apiKey: self.validAPIKey,
                                           authenticationToken: self.validAuthenticationToken)
        return ClientConfiguration(baseURL: self.validBaseURL, credentials: credentials)
    }

    private func validSocketConfig() -> ClientConfiguration {
        let credentials = ClientCredential(apiKey: self.validAPIKey,
                                           authenticationToken: self.validAuthenticationToken)
        return ClientConfiguration(baseURL: self.validWebsocketURL, credentials: credentials)
    }

    func areKeysValid() -> Bool {
        return
            self.validBaseURL != ""
            && self.validWebsocketURL != ""
            && self.validAPIKey != ""
            && self.validAuthenticationToken != ""
            && self.validTokenId != ""
    }

    /// This function loads the keys from the environment variables,
    /// you can specify these vriable when running tests on a CI server like so
    /// xcodebuild -project OmiseGO.xcodeproj \
    /// -scheme "OmiseGO" \
    /// -sdk iphonesimulator \
    /// -destination 'platform=iOS Simulator,name=iPhone 8' \
    /// OMG_BASE_URL="https://some.base.url" \
    /// OMG_API_KEY="someKey" \
    /// OMG_AUTHENTICATION_TOKEN="someToken" \
    /// OMG_TOKEN_ID="someTokenId" \
    /// test
    private func loadEnvKeys() {
        let plistSecrets = self.loadSecretPlistFile()
        self.validBaseURL =
            plistSecrets?[LiveClientTestCase.OMG_BASE_URL] != nil &&
            plistSecrets![LiveClientTestCase.OMG_BASE_URL] != "" ?
            plistSecrets![LiveClientTestCase.OMG_BASE_URL]! :
            ProcessInfo.processInfo.environment[LiveClientTestCase.OMG_BASE_URL]!
        self.validWebsocketURL =
            plistSecrets?[LiveClientTestCase.OMG_WEBSOCKET_URL] != nil &&
            plistSecrets![LiveClientTestCase.OMG_WEBSOCKET_URL] != "" ?
            plistSecrets![LiveClientTestCase.OMG_WEBSOCKET_URL]! :
            ProcessInfo.processInfo.environment[LiveClientTestCase.OMG_WEBSOCKET_URL]!
        self.validAPIKey =
            plistSecrets?[LiveClientTestCase.OMG_API_KEY] != nil &&
            plistSecrets![LiveClientTestCase.OMG_API_KEY] != "" ?
            plistSecrets![LiveClientTestCase.OMG_API_KEY]! :
            ProcessInfo.processInfo.environment[LiveClientTestCase.OMG_API_KEY]!
        self.validAuthenticationToken =
            plistSecrets?[LiveClientTestCase.OMG_AUTHENTICATION_TOKEN] != nil &&
            plistSecrets![LiveClientTestCase.OMG_AUTHENTICATION_TOKEN] != "" ?
            plistSecrets![LiveClientTestCase.OMG_AUTHENTICATION_TOKEN]! :
            ProcessInfo.processInfo.environment[LiveClientTestCase.OMG_AUTHENTICATION_TOKEN]!
        self.validTokenId =
            plistSecrets?[LiveClientTestCase.OMG_TOKEN_ID] != nil &&
            plistSecrets![LiveClientTestCase.OMG_TOKEN_ID] != "" ?
            plistSecrets![LiveClientTestCase.OMG_TOKEN_ID]! :
            ProcessInfo.processInfo.environment[LiveClientTestCase.OMG_TOKEN_ID]!
    }

    private func loadSecretPlistFile() -> [String: String]? {
        guard let path = Bundle(for: LiveClientTestCase.self).path(forResource: "secret", ofType: "plist") else { return nil }
        return NSDictionary(contentsOfFile: path) as? [String: String]
    }
}
