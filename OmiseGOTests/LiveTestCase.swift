//
//  LiveTestCase.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 18/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import Foundation
import XCTest
import OmiseGO

class LiveTestCase: XCTestCase {

    private static let BASE_URL = "OMG_BASE_URL"
    private static let OMG_API_KEY = "OMG_API_KEY"
    private static let OMG_AUTHENTICATION_TOKEN = "OMG_AUTHENTICATION_TOKEN"
    private static let OMG_MINTED_TOKEN_ID = "OMG_MINTED_TOKEN_ID"

    var validBaseURL: String = ""
    var validAPIKey: String = ""
    var validAuthenticationToken: String = ""
    var validMintedTokenId: String = ""

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
        self.testClient = OMGClient(config: self.validConfig())
    }

    var testClient: OMGClient!

    private func validConfig() -> OMGConfiguration {
        return OMGConfiguration(baseURL: validBaseURL,
                                apiKey: validAPIKey,
                                authenticationToken: validAuthenticationToken)
    }

    func areKeysValid() -> Bool {
        return
            self.validBaseURL != ""
            && self.validAPIKey != ""
            && self.validAuthenticationToken != ""
            && self.validMintedTokenId != ""
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
    /// OMG_MINTED_TOKEN_ID="someMintedTokenId" \
    /// test
    private func loadEnvKeys() {
        let plistSecrets = self.loadSecretPlistFile()
        self.validBaseURL =
            plistSecrets?[LiveTestCase.BASE_URL] != nil &&
            plistSecrets![LiveTestCase.BASE_URL] != "" ?
            plistSecrets![LiveTestCase.BASE_URL]! :
            ProcessInfo.processInfo.environment[LiveTestCase.BASE_URL]!
        self.validAPIKey =
            plistSecrets?[LiveTestCase.OMG_API_KEY] != nil &&
            plistSecrets![LiveTestCase.OMG_API_KEY] != "" ?
            plistSecrets![LiveTestCase.OMG_API_KEY]! :
            ProcessInfo.processInfo.environment[LiveTestCase.OMG_API_KEY]!
        self.validAuthenticationToken =
            plistSecrets?[LiveTestCase.OMG_AUTHENTICATION_TOKEN] != nil &&
            plistSecrets![LiveTestCase.OMG_AUTHENTICATION_TOKEN] != "" ?
            plistSecrets![LiveTestCase.OMG_AUTHENTICATION_TOKEN]! :
            ProcessInfo.processInfo.environment[LiveTestCase.OMG_AUTHENTICATION_TOKEN]!
        self.validMintedTokenId =
            plistSecrets?[LiveTestCase.OMG_MINTED_TOKEN_ID] != nil &&
            plistSecrets![LiveTestCase.OMG_MINTED_TOKEN_ID] != "" ?
            plistSecrets![LiveTestCase.OMG_MINTED_TOKEN_ID]! :
            ProcessInfo.processInfo.environment[LiveTestCase.OMG_MINTED_TOKEN_ID]!
    }

    private func loadSecretPlistFile() -> [String: String]? {
        guard let path = Bundle(for: LiveTestCase.self).path(forResource: "secret", ofType: "plist") else { return nil }
        return NSDictionary(contentsOfFile: path) as? [String: String]
    }

}
