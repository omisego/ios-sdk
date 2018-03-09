//
//  TransactionConsumeTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 13/2/2018.
//  Copyright © 2017-2018 Omise Go Ptd. Ltd. All rights reserved.
//

import XCTest
import OmiseGO

class TransactionConsumeTest: XCTestCase {

    func testEquatable() {
        let transactionConsume1 = StubGenerator.transactionConsume(id: "1")
        let transactionConsume2 = StubGenerator.transactionConsume(id: "1")
        let transactionConsume3 = StubGenerator.transactionConsume(id: "2")
        XCTAssertEqual(transactionConsume1, transactionConsume2)
        XCTAssertNotEqual(transactionConsume1, transactionConsume3)
    }

    func testHashable() {
        let transactionConsume1 = StubGenerator.transactionConsume(id: "1")
        let transactionConsume2 = StubGenerator.transactionConsume(id: "1")
        let set: Set<TransactionConsume> = [transactionConsume1, transactionConsume2]
        XCTAssertEqual(transactionConsume1.hashValue, "1".hashValue)
        XCTAssertEqual(set.count, 1)
    }

}
