//
//  TransactionConsumeTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 13/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class TransactionConsumeTest: XCTestCase {

    let mintedToken = MintedToken(id: "", symbol: "", name: "", subUnitToUnit: 1)

    func testEquatable() {
        let transactionConsume1 = TransactionConsume(id: "1",
                                                     status: .confirmed,
                                                     amount: 1,
                                                     mintedToken: mintedToken,
                                                     correlationId: "",
                                                     idempotencyToken: "",
                                                     transferId: "",
                                                     userId: "",
                                                     transactionRequestId: "",
                                                     address: "")
        let transactionConsume2 = TransactionConsume(id: "1",
                                                     status: .confirmed,
                                                     amount: 1,
                                                     mintedToken: mintedToken,
                                                     correlationId: "",
                                                     idempotencyToken: "",
                                                     transferId: "",
                                                     userId: "",
                                                     transactionRequestId: "",
                                                     address: "")
        let transactionConsume3 = TransactionConsume(id: "2",
                                                     status: .confirmed,
                                                     amount: 1,
                                                     mintedToken: mintedToken,
                                                     correlationId: "",
                                                     idempotencyToken: "",
                                                     transferId: "",
                                                     userId: "",
                                                     transactionRequestId: "",
                                                     address: "")
        XCTAssertEqual(transactionConsume1, transactionConsume2)
        XCTAssertNotEqual(transactionConsume1, transactionConsume3)
    }

    func testHashable() {
        let transactionConsume1 = TransactionConsume(id: "1",
                                                     status: .confirmed,
                                                     amount: 1,
                                                     mintedToken: mintedToken,
                                                     correlationId: "",
                                                     idempotencyToken: "",
                                                     transferId: "",
                                                     userId: "",
                                                     transactionRequestId: "",
                                                     address: "")
        let transactionConsume2 = TransactionConsume(id: "1",
                                                     status: .confirmed,
                                                     amount: 1,
                                                     mintedToken: mintedToken,
                                                     correlationId: "",
                                                     idempotencyToken: "",
                                                     transferId: "",
                                                     userId: "",
                                                     transactionRequestId: "",
                                                     address: "")
        let set: Set<TransactionConsume> = [transactionConsume1, transactionConsume2]
        XCTAssertEqual(transactionConsume1.hashValue, "1".hashValue)
        XCTAssertEqual(set.count, 1)
    }

}
