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

    func testQRCodeImage() {
        let transactionRequest = TransactionRequest(id: "1",
                                                    type: .receive,
                                                    mintedTokenId: "9e3d1fc4-5899-4297-9a62-a9f524d5ca27",
                                                    amount: nil,
                                                    providerUserId: "2242a469-68ab-4aa8-afd6-cdb6bd853ba0",
                                                    address: "1927dd11-8d05-42f8-8528-867d51c756c2",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                    serviceEndpoint: "https://example.com/test")
        XCTAssertNotNil(transactionRequest.qrImage())
    }

    func testEquatable() {
        let transactionRequest1 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     address: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let transactionRequest2 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     address: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let transactionRequest3 = TransactionRequest(id: "2",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     address: "",
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
                                                     address: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let transactionRequest2 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     providerUserId: "",
                                                     address: "",
                                                     correlationId: "",
                                                     serviceEndpoint: "")
        let set: Set<TransactionRequest> = [transactionRequest1, transactionRequest2]
        XCTAssertEqual(transactionRequest1.hashValue, "1".hashValue)
        XCTAssertEqual(set.count, 1)
    }

}
