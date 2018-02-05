//
//  TransactionRequestTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 5/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class TransactionRequestTest: XCTestCase {

    func testEquatable() {
        let transactionRequest1 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     balanceId: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let transactionRequest2 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     balanceId: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let transactionRequest3 = TransactionRequest(id: "2",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     balanceId: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        XCTAssertEqual(transactionRequest1, transactionRequest2)
        XCTAssertNotEqual(transactionRequest1, transactionRequest3)
    }

    func testHashable() {
        let transactionRequest1 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     balanceId: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let transactionRequest2 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     balanceId: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let set: Set<TransactionRequest> = [transactionRequest1, transactionRequest2]
        XCTAssertEqual(transactionRequest1.hashValue, "1".hashValue)
        XCTAssertEqual(set.count, 1)
    }

}
