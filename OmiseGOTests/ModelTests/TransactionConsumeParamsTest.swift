//
//  TransactionConsumeParamsTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 7/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class TransactionConsumeParamsTest: XCTestCase {

    func testInitCorrectlyWhenGivenAnAmountFromATransactionRequest() {
        let transactionRequest = TransactionRequest(id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                                                    type: .receive,
                                                    mintedTokenId: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1",
                                                    amount: 1337,
                                                    address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                    status: .pending)
        XCTAssertNotNil(TransactionConsumeParams(transactionRequest: transactionRequest,
                                                 idempotencyToken: "123",
                                                 metadata: [:]))
    }

    func testFailInitWhenGivenNotGivenAnAmount() {
        let transactionRequest = TransactionRequest(id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                                                    type: .receive,
                                                    mintedTokenId: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1",
                                                    amount: nil,
                                                    address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                    status: .pending)
        XCTAssertNil(TransactionConsumeParams(transactionRequest: transactionRequest,
                                              idempotencyToken: "123",
                                              metadata: [:]))
    }

    func testAmountIsTakenFromParamsIfTransactionRequestAmountIsNull() {
        let transactionRequest = TransactionRequest(id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                                                    type: .receive,
                                                    mintedTokenId: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1",
                                                    amount: nil,
                                                    address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                    status: .pending)
        let params = TransactionConsumeParams(transactionRequest: transactionRequest,
                                              amount: 3000,
                                              idempotencyToken: "123",
                                              metadata: [:])!
        XCTAssertEqual(params.amount, 3000)
    }

    func testAmountIsTakenFromAmountParamFirst() {
        let transactionRequest = TransactionRequest(id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                                                    type: .receive,
                                                    mintedTokenId: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1",
                                                    amount: 1337,
                                                    address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                    status: .pending)
        let params = TransactionConsumeParams(transactionRequest: transactionRequest,
                                              amount: 3000,
                                              idempotencyToken: "123",
                                              metadata: [:])!
        XCTAssertEqual(params.amount, 3000)
    }

}