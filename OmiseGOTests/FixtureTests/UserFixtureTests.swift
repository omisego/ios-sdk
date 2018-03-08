//
//  UserFixtureTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 11/10/2017 BE.
//  Copyright © 2017-2018 Omise Go Ptd. Ltd. All rights reserved.
//

import XCTest
import OmiseGO

class UserFixtureTests: FixtureTestCase {

    func testGetCurrentUser() {
        let expectation = self.expectation(description: "Get current user")
        let request = User.getCurrent(using: self.testCustomClient) { (result) in
            defer { expectation.fulfill() }
            switch result {
            case .success(let user):
                XCTAssertEqual(user.id, "cec34607-0761-4a59-8357-18963e42a1aa")
                XCTAssertEqual(user.providerUserId, "wijf-fbancomw-dqwjudb")
                XCTAssertEqual(user.username, "john.doe@example.com")
                XCTAssertEqual(user.metadata["first_name"] as? String, "John")
                XCTAssertEqual(user.metadata["last_name"] as? String, "Doe")
                if let object = user.metadata["object"] as? [String: Any] {
                    XCTAssertEqual(object["my_key"] as? String, "my_value")
                    if let nestedObject = object["my_nested_object"] as? [String: Any] {
                        XCTAssertEqual(nestedObject["my_nested_key"] as? String, "my_nested_value")
                    } else {
                        XCTFail("Failed to parse metadata nested object")
                    }
                } else {
                    XCTFail("Failed to parse metadata object")
                }
                if let array = user.metadata["array"] as? [Any] {
                    XCTAssertEqual(array[0] as? String, "value_1")
                    XCTAssertEqual(array[1] as? String, "value_2")
                } else {
                    XCTFail("Failed to parse metadata array")
                }
            case .fail(let error):
                XCTFail("\(error)")
            }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

}
