//
//  SocketTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 23/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

import XCTest
import Starscream
@testable import OmiseGO

class SocketTest: XCTestCase {

    var client: FixtureWebsocketClient!
    var socket: Socket!
    
    override func setUp() {
        super.setUp()
        self.client = FixtureWebsocketClient()
        self.socket = Socket(webSocket: self.client)
    }

    func testJoinChannelWritesJoinData() {
        XCTAssertNil(self.client.didWriteData)
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNotNil(self.client.didWriteData)
    }

    func testConnectIfNotConnectedWhenJoiningChannel() {
        XCTAssertFalse(self.client.isConnected)
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        XCTAssertTrue(self.client.isConnected)
    }

    func testDoesNotJoinSameChannelTwice() {
        XCTAssertNil(self.client.didWriteData)
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNotNil(self.client.didWriteData)
        self.client.didWriteData = nil
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNil(self.client.didWriteData)
    }

    func testCanJoinTwoDifferentChannels() {
        XCTAssertNil(self.client.didWriteData)
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNotNil(self.client.didWriteData)
        self.client.didWriteData = nil
        self.socket.join(withTopic: "an_other_topic", dispatcher: nil)
        XCTAssertNotNil(self.client.didWriteData)
    }

    func testDoesNotJoinChannelIfNotConnectedButQueueUntilConnected() {
        let expectation = self.expectation(description: "Queue message if not connected then dispatch it")
        self.client.shouldAutoConnect = false
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        self.client.delegate = DummyWebSocketDelegate(expectation: expectation)
        XCTAssertNil(self.client.didWriteData)
        self.client.shouldAutoConnect = true
        self.client.connect()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(self.client.didWriteData)
    }

    func testLeaveChannelWritesLeaveData() {
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        self.client.didWriteData = nil
        XCTAssertNil(self.client.didWriteData)
        self.socket.leaveChannel(withTopic: "a_topic")
        XCTAssertNotNil(self.client.didWriteData)
    }

    func testDisconnectIfNotChannelActive() {
        self.socket.join(withTopic: "a_topic", dispatcher: nil)
        XCTAssertTrue(self.client.isConnected)
        self.socket.leaveChannel(withTopic: "a_topic")
        XCTAssertNotNil(self.client.didWriteData)
        self.client.simulateReply()
        XCTAssertFalse(self.client.isConnected)
    }

    
}
