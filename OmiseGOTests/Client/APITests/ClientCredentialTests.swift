//
//  ClientCredentialTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 9/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import OmiseGO
import XCTest

class ClientCredentialTests: XCTestCase {
    func testFailToEncodeAuthorizationHeaderIfAuthenticationTokenIsNotSpecified() {
        var credentials = ClientCredential(apiKey: "api_key", authenticationToken: "auth_token")
        credentials.invalidate()
        XCTAssertThrowsError(try credentials.authentication())
    }
}
