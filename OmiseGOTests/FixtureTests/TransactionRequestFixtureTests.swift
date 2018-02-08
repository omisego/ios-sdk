//
//  TransactionRequestFixtureTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 5/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class TransactionRequestFixtureTests: FixtureTestCase {

    func testGenerateTransactionRequest() {
        let expectation =
            self.expectation(description: "Generate a transaction request corresponding to the params provided")
        let params = TransactionRequestCreateParams(type: .receive,
                                              mintedTokenId: "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95",
                                              amount: 1337,
                                              address: "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
                                              correlationId: "31009545-db10-4287-82f4-afb46d9741d8")
        let request =
            TransactionRequest.generateTransactionRequest(using: self.testCustomClient, params: params) { (result) in
            defer { expectation.fulfill() }
            switch result {
            case .success(data: let transactionRequest):
                XCTAssertEqual(transactionRequest.id, "8eb0160e-1c96-481a-88e1-899399cc84dc")
                XCTAssertEqual(transactionRequest.mintedTokenId, "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95")
                XCTAssertEqual(transactionRequest.amount, 1337)
                XCTAssertEqual(transactionRequest.address, "3b7f1c68-e3bd-4f8f-9916-4af19be95d00")
                XCTAssertEqual(transactionRequest.correlationId, "31009545-db10-4287-82f4-afb46d9741d8")
            case .fail(error: let error):
                XCTFail("\(error)")
            }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

    func tesGetTransactionRequest() {
        let expectation =
            self.expectation(description: "Retrieve a transaction request corresponding to the params provided")
        let request =
            TransactionRequest.retrieveTransactionRequest(using: self.testCustomClient,
                                                          id: "8eb0160e-1c96-481a-88e1-899399cc84dc") { (result) in
                defer { expectation.fulfill() }
                switch result {
                case .success(data: let transactionRequest):
                    XCTAssertEqual(transactionRequest.id, "8eb0160e-1c96-481a-88e1-899399cc84dc")
                    XCTAssertEqual(transactionRequest.mintedTokenId, "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95")
                    XCTAssertEqual(transactionRequest.amount, 1337)
                    XCTAssertEqual(transactionRequest.address, "3b7f1c68-e3bd-4f8f-9916-4af19be95d00")
                    XCTAssertEqual(transactionRequest.correlationId, "31009545-db10-4287-82f4-afb46d9741d8")
                case .fail(error: let error):
                    XCTFail("\(error)")
                }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

    func testConsumeTransactionRequest() {
        let expectation =
            self.expectation(description: "Consume a transaction request corresponding to the params provided")
        let transactionRequest = TransactionRequest(id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                                                    type: .receive,
                                                    mintedTokenId: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1",
                                                    amount: 1337,
                                                    address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                    status: .pending)
        let params = TransactionConsumeParams(transactionRequest: transactionRequest, idempotencyToken: "123")!
        let request =
            TransactionRequest.consumeTransactionRequest(using: self.testCustomClient, params: params) { (result) in
                defer { expectation.fulfill() }
                switch result {
                case .success(data: let transactionRequest):
                    XCTAssertEqual(transactionRequest.id, "8eb0160e-1c96-481a-88e1-899399cc84dc")
                    XCTAssertEqual(transactionRequest.mintedTokenId, "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95")
                    XCTAssertEqual(transactionRequest.amount, 1337)
                    XCTAssertEqual(transactionRequest.address, "3b7f1c68-e3bd-4f8f-9916-4af19be95d00")
                    XCTAssertEqual(transactionRequest.correlationId, "31009545-db10-4287-82f4-afb46d9741d8")
                case .fail(error: let error):
                    XCTFail("\(error)")
                }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

}
