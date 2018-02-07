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
        let transactionRequest = TransactionRequest(id: "39dbf582-dc4b-41c4-8373-2e0f4359c7ef",
                                                    type: .receive,
                                                    mintedTokenId: "BTC:9e3d1fc4-5899-4297-9a62-a9f524d5ca27",
                                                    amount: nil,
                                                    address: "1927dd11-8d05-42f8-8528-867d51c756c2",
                                                    correlationId: "31009545-db10-4287-82f4-afb46d9741d8")
        if let qrImage = transactionRequest.qrImage() {
            let decodedText = QRTestHelper.readQRCode(fromImage: qrImage)
            XCTAssertEqual(decodedText, transactionRequest.id)
        } else {
            XCTFail("QR image should not be nil")
        }
    }

    func testEquatable() {
        let transactionRequest1 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     address: "",
                                                     correlationId: "")
        let transactionRequest2 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     address: "",
                                                     correlationId: "")
        let transactionRequest3 = TransactionRequest(id: "2",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     address: "",
                                                     correlationId: "")
        XCTAssertEqual(transactionRequest1, transactionRequest2)
        XCTAssertNotEqual(transactionRequest1, transactionRequest3)
    }

    func testHashable() {
        let transactionRequest1 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     address: "",
                                                     correlationId: "")
        let transactionRequest2 = TransactionRequest(id: "1",
                                                     type: .receive,
                                                     mintedTokenId: "",
                                                     amount: nil,
                                                     address: "",
                                                     correlationId: "")
        let set: Set<TransactionRequest> = [transactionRequest1, transactionRequest2]
        XCTAssertEqual(transactionRequest1.hashValue, "1".hashValue)
        XCTAssertEqual(set.count, 1)
    }

}
