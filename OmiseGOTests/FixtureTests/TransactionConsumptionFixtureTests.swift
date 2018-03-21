//
//  TransactionConsumptionFixtureTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 13/2/2018.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import XCTest
import OmiseGO

class TransactionConsumptionFixtureTests: FixtureTestCase {

    func testConsumeTransactionRequest() {
        let expectation =
            self.expectation(description: "Consume a transaction request corresponding to the params provided")
        let transactionRequest = StubGenerator.transactionRequest(
                id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                type: .receive,
                mintedToken: StubGenerator.mintedToken(id: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1"),
                amount: 1337,
                address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                status: .valid)
        let params = TransactionConsumptionParams(
                transactionRequest: transactionRequest,
                address: nil,
                mintedTokenId: nil,
                idempotencyToken: "123",
                correlationId: nil,
                expirationDate: nil,
                metadata: [:])!
        let request =
            TransactionConsumption.consumeTransactionRequest(using: self.testCustomClient, params: params) { (result) in
                defer { expectation.fulfill() }
                switch result {
                case .success(data: let transactionConsumption):
                    XCTAssertEqual(transactionConsumption.id, "8eb0160e-1c96-481a-88e1-899399cc84dc")
                    let mintedToken = transactionConsumption.mintedToken
                    XCTAssertEqual(mintedToken.id, "BTC:123")
                    XCTAssertEqual(mintedToken.symbol, "BTC")
                    XCTAssertEqual(mintedToken.name, "Bitcoin")
                    XCTAssertEqual(mintedToken.subUnitToUnit, 100000)
                    XCTAssertEqual(transactionConsumption.amount, 1337)
                    XCTAssertEqual(transactionConsumption.address, "3b7f1c68-e3bd-4f8f-9916-4af19be95d00")
                    XCTAssertEqual(transactionConsumption.correlationId, "31009545-db10-4287-82f4-afb46d9741d8")
                    XCTAssertEqual(transactionConsumption.idempotencyToken, "31009545-db10-4287-82f4-afb46d9741d8")
                    XCTAssertEqual(transactionConsumption.transactionId, "6ca40f34-6eaa-43e1-b2e1-a94ff3660988")
                    XCTAssertEqual(transactionConsumption.userId, "6f56efa1-caf9-4348-8e0f-f5af283f17ee")
                    XCTAssertEqual(transactionConsumption.transactionRequestId, "907056a4-fc2d-47cb-af19-5e73aade7ece")
                    XCTAssertEqual(transactionConsumption.status, .confirmed)
                case .fail(error: let error):
                    XCTFail("\(error)")
                }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

}