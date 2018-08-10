//
//  TestConfiguration.swift
//  Tests
//
//  Created by Mederic Petit on 9/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import OmiseGO

struct TestConfiguration: Configuration {
    let apiVersion: String = "1"

    let baseURL: String

    var credentials: Credential

    let debugLog: Bool = false

    init(baseURL: String = "http://localhost:4000", credentials: TestCredential = TestCredential()) {
        self.baseURL = baseURL
        self.credentials = credentials
    }
}