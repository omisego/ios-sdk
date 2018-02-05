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
                                         mintedTokenId: "861020af-17b6-49ee-a0cb-661a4d2d1f95",
                                         amount: nil,
                                         providerUserId: "6082319c-4e74-4a5d-ab87-e0934ba1368d",
                                         balanceId: "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
                                         correlationId: "89bd5aff-27f3-48bc-8d87-0adfd065fcbe")
            let encodedData = try JSONEncoder().encode(transactionRequestParams)
            //swiftlint:disable:next line_length
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, "{\"balance_id\":\"3b7f1c68-e3bd-4f8f-9916-4af19be95d00\",\"correlation_id\":\"89bd5aff-27f3-48bc-8d87-0adfd065fcbe\",\"minted_token_id\":\"861020af-17b6-49ee-a0cb-661a4d2d1f95\",\"type\":\"receive\",\"provider_user_id\":\"6082319c-4e74-4a5d-ab87-e0934ba1368d\"}")
        } catch let thrownError {
            XCTFail(thrownError.localizedDescription)
        }
    }

    func testTransactionRequestParamsEncodingWithAmount() {
        do {
            let transactionRequestParams =
                TransactionRequestParams(type: .receive,
                                         mintedTokenId: "861020af-17b6-49ee-a0cb-661a4d2d1f95",
                                         amount: 1337,
                                         providerUserId: "6082319c-4e74-4a5d-ab87-e0934ba1368d",
                                         balanceId: "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
                                         correlationId: "89bd5aff-27f3-48bc-8d87-0adfd065fcbe")
            let encodedData = try JSONEncoder().encode(transactionRequestParams)
            //swiftlint:disable:next line_length
            XCTAssertEqual(String(data: encodedData, encoding: .utf8)!, "{\"amount\":1337,\"balance_id\":\"3b7f1c68-e3bd-4f8f-9916-4af19be95d00\",\"minted_token_id\":\"861020af-17b6-49ee-a0cb-661a4d2d1f95\",\"correlation_id\":\"89bd5aff-27f3-48bc-8d87-0adfd065fcbe\",\"type\":\"receive\",\"provider_user_id\":\"6082319c-4e74-4a5d-ab87-e0934ba1368d\"}")
        } catch let thrownError {
            XCTFail(thrownError.localizedDescription)
        }
    }

}
