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
        let params = TransactionRequestParams(type: .receive,
                                              mintedTokenId: "861020af-17b6-49ee-a0cb-661a4d2d1f95",
                                              amount: 1337,
                                              providerUserId: "6082319c-4e74-4a5d-ab87-e0934ba1368d",
                                              balanceId: "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
                                              correlationId: "89bd5aff-27f3-48bc-8d87-0adfd065fcbe")
        let request =
            TransactionRequest.generateTransactionRequest(using: self.testCustomClient, params: params) { (result) in
            defer { expectation.fulfill() }
            switch result {
            case .success(data: let transactionRequest):
                XCTAssertEqual(transactionRequest.id, "8eb0160e-1c96-481a-88e1-899399cc84dc")
                XCTAssertEqual(transactionRequest.mintedTokenId, "861020af-17b6-49ee-a0cb-661a4d2d1f95")
                XCTAssertEqual(transactionRequest.amount, 1337)
                XCTAssertEqual(transactionRequest.providerUserId, "6082319c-4e74-4a5d-ab87-e0934ba1368d")
                XCTAssertEqual(transactionRequest.balanceId, "3b7f1c68-e3bd-4f8f-9916-4af19be95d00")
                XCTAssertEqual(transactionRequest.correlationId, "89bd5aff-27f3-48bc-8d87-0adfd065fcbe")
                XCTAssertEqual(transactionRequest.serviceEndpoint, "https://example.com/transaction-request.consume")
            case .fail(error: let error):
                XCTFail("\(error)")
            }
        }
        XCTAssertNotNil(request)
        waitForExpectations(timeout: 15.0, handler: nil)
    }

}
