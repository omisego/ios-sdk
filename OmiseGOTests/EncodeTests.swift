//
//  EncodeTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 5/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class EncodeTests: XCTestCase {

    func testTransactionRequestParamsEncodingWithoutAmount() {
        do {
            let transactionRequestParams =
                TransactionRequestParams(type: .receive,
                                         mintedTokenId: "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95",
                                         amount: nil,
                                         address: "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
                                         correlationId: "31009545-db10-4287-82f4-afb46d9741d8")
            let encodedData = try JSONEncoder().encode(transactionRequestParams)
            //swiftlint:disable:next line_length
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, "{\"amount\":null,\"correlation_id\":\"31009545-db10-4287-82f4-afb46d9741d8\",\"token_id\":\"BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95\",\"type\":\"receive\",\"address\":\"3b7f1c68-e3bd-4f8f-9916-4af19be95d00\"}")
        } catch let thrownError {
            XCTFail(thrownError.localizedDescription)
        }
    }

    func testTransactionRequestParamsEncodingWithAmount() {
        do {
            let transactionRequestParams =
                TransactionRequestParams(type: .receive,
                                         mintedTokenId: "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95",
                                         amount: 1337,
                                         address: "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
                                         correlationId: "31009545-db10-4287-82f4-afb46d9741d8")
            let encodedData = try JSONEncoder().encode(transactionRequestParams)
            //swiftlint:disable:next line_length
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, "{\"amount\":1337,\"correlation_id\":\"31009545-db10-4287-82f4-afb46d9741d8\",\"token_id\":\"BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95\",\"type\":\"receive\",\"address\":\"3b7f1c68-e3bd-4f8f-9916-4af19be95d00\"}")
        } catch let thrownError {
            XCTFail(thrownError.localizedDescription)
        }
    }

    func testStandardTransactionRequestEncoding() {
        do {
            let transactionRequest = TransactionRequest(id: "0a8a4a98-794b-419e-b92d-514e83657e75",
                                                        type: .receive,
                                                        mintedTokenId: "BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1",
                                                        amount: 1337,
                                                        address: "3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d",
                                                        correlationId: "31009545-db10-4287-82f4-afb46d9741d8",
                                                        serviceEndpoint: "https://example.com/test")
            let encodedData = try JSONEncoder().encode(transactionRequest)
            //swiftlint:disable:next line_length
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, "{\"amount\":1337,\"id\":\"0a8a4a98-794b-419e-b92d-514e83657e75\",\"token_id\":\"BTC:5ee328ec-b9e2-46a5-88bb-c8b15ea6b3c1\",\"type\":\"receive\",\"service_endpoint\":\"https:\\/\\/example.com\\/test\",\"address\":\"3bfe0ff7-f43e-4ac6-bdf9-c4a290c40d0d\"}")
        } catch let thrownError {
            XCTFail(thrownError.localizedDescription)
        }
    }

}
