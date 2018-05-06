//
//  APIEndpointTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 14/2/2018.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import XCTest
@testable import OmiseGO

class APIEndpointTest: XCTestCase {

    let validTransactionConsumptionParams = StubGenerator.transactionConsumptionParams()
    let validTransactionCreateParams = StubGenerator.transactionRequestCreateParams()
    let validTransactionGetParams = StubGenerator.transactionRequestGetParams()
    let validTransactionListParams = StubGenerator.transactionListParams()

    func testPath() {
        XCTAssertEqual(APIEndpoint.getCurrentUser.path, "/me.get")
        XCTAssertEqual(APIEndpoint.getAddresses.path, "/me.list_balances")
        XCTAssertEqual(APIEndpoint.getSettings.path, "/me.get_settings")
        XCTAssertEqual(APIEndpoint.getTransactions(params: self.validTransactionListParams).path,
                       "/me.list_transactions")
        XCTAssertEqual(APIEndpoint.transactionRequestCreate(params: self.validTransactionCreateParams).path,
                       "/me.create_transaction_request")
        XCTAssertEqual(APIEndpoint.transactionRequestGet(params: self.validTransactionGetParams).path,
                       "/me.get_transaction_request")
        XCTAssertEqual(APIEndpoint.transactionRequestConsume(params: self.validTransactionConsumptionParams).path,
                       "/me.consume_transaction_request")
        XCTAssertEqual(APIEndpoint.logout.path, "/logout")
    }

    func testTask() {
        switch APIEndpoint.getCurrentUser.task {
        case .requestPlain: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.getAddresses.task {
        case .requestPlain: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.getSettings.task {
        case .requestPlain: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.getTransactions(params: self.validTransactionListParams).task {
        case .requestParameters: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.logout.task {
        case .requestPlain: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.transactionRequestCreate(params: self.validTransactionCreateParams).task {
        case .requestParameters: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.transactionRequestGet(params: self.validTransactionGetParams).task {
        case .requestParameters: break
        default: XCTFail("Wrong task")
        }
        switch APIEndpoint.transactionRequestConsume(params: self.validTransactionConsumptionParams).task {
        case .requestParameters: break
        default: XCTFail("Wrong task")
        }
    }
}
