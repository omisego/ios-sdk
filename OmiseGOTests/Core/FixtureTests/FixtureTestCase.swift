//
//  FixtureTestCase.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 10/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import OmiseGO
import XCTest

class FixtureTestCase: XCTestCase {
    var testClient: FixtureClient {
        let bundle = Bundle(for: FixtureTestCase.self)
        let url = bundle.url(forResource: "core_fixtures", withExtension: nil)!
        return FixtureClient(fixturesDirectoryURL: url)
    }
}
