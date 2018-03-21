//
//  RequestBuilderTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 21/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

import XCTest
@testable import OmiseGO

class RequestBuilderTests: XCTestCase {

    var config = OMGConfiguration(websocketsBaseUrl: "ws://example.com",
                                  baseURL: "https://example.com",
                                  apiKey: "123",
                                  authenticationToken: "123")
    var requestBuilder: RequestBuilder!
    
    override func setUp() {
        super.setUp()
        let requestParam = RequestParameters(config: self.config)
        self.requestBuilder = RequestBuilder(requestParameters: requestParam)
    }
    
    func buildHttpRequestWithParams() {
        let dummyObject = DummyTestObject(object: "object")
        let endpoint = APIEndpoint.custom(path: "/test",
                                          task: Task.requestParameters(parameters: dummyObject))
        do {
            let urlRequest = try self.requestBuilder.buildHTTPURLRequest(withEndpoint: endpoint)
            XCTAssertEqual(urlRequest.httpMethod, "POST")
            XCTAssertEqual(urlRequest.cachePolicy, .useProtocolCachePolicy)
            XCTAssertEqual(urlRequest.timeoutInterval, 6.0)
            XCTAssertEqual(urlRequest.httpBody!, dummyObject.encodedPayload()!)
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Authorization"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Accept"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Content-Type"])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testBuildRequestWithAdditionalHeaderFromParams() {
        let transactionConsumptionParams = StubGenerator.transactionConsumptionParams()
        let endpoint = APIEndpoint.transactionRequestConsume(params: transactionConsumptionParams)
        do {
            let urlRequest = try self.requestBuilder.buildHTTPURLRequest(withEndpoint: endpoint)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields!["Idempotency-Token"],
                           transactionConsumptionParams.idempotencyToken)
            XCTAssertEqual(urlRequest.httpMethod, "POST")
            XCTAssertEqual(urlRequest.cachePolicy, .useProtocolCachePolicy)
            XCTAssertEqual(urlRequest.timeoutInterval, 6.0)
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Authorization"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Accept"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Content-Type"])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testBuildRequestWithoutParams() {
        let endpoint = APIEndpoint.custom(path: "/test", task: Task.requestPlain)
        do {
            let urlRequest = try self.requestBuilder.buildHTTPURLRequest(withEndpoint: endpoint)
            XCTAssertEqual(urlRequest.httpMethod, "POST")
            XCTAssertEqual(urlRequest.cachePolicy, .useProtocolCachePolicy)
            XCTAssertEqual(urlRequest.timeoutInterval, 6.0)
            XCTAssertEqual(urlRequest.httpBody, nil)
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Authorization"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Accept"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Content-Type"])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    func testBuildWebsocketRequest() {
        do {
            let urlRequest = try self.requestBuilder.buildWebsocketRequest()
            XCTAssertEqual(urlRequest.httpMethod, "GET")
            XCTAssertEqual(urlRequest.timeoutInterval, 6.0)
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Authorization"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Accept"])
            XCTAssertNotNil(urlRequest.allHTTPHeaderFields!["Content-Type"])
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
}
