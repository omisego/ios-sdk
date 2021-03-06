//
//  SocketClientTests.swift
//  Tests
//
//  Created by Mederic Petit on 23/3/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

@testable import OmiseGO
import Starscream
import XCTest

class SocketClientTests: XCTestCase {
    var websocket: FixtureWebsocketClient!
    var socketClient: SocketClient!

    override func setUp() {
        super.setUp()
        self.websocket = FixtureWebsocketClient()
        self.socketClient = SocketClient(websocketClient: self.websocket)
    }

    func testJoinChannelWritesJoinData() {
        XCTAssertNil(self.websocket.didWriteData)
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNotNil(self.websocket.didWriteData)
    }

    func testConnectIfNotConnectedWhenJoiningChannel() {
        XCTAssertFalse(self.websocket.isConnected)
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        XCTAssertTrue(self.websocket.isConnected)
    }

    func testDoesNotJoinSameChannelTwice() {
        XCTAssertNil(self.websocket.didWriteData)
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNotNil(self.websocket.didWriteData)
        self.websocket.didWriteData = nil
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNil(self.websocket.didWriteData)
    }

    func testCanJoinTwoDifferentChannels() {
        XCTAssertNil(self.websocket.didWriteData)
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        XCTAssertNotNil(self.websocket.didWriteData)
        self.websocket.didWriteData = nil
        self.socketClient.joinChannel(withTopic: "an_other_topic", dispatcher: nil)
        XCTAssertNotNil(self.websocket.didWriteData)
    }

    func testDoesNotJoinChannelIfNotConnectedButQueueUntilConnected() {
        let expectation = self.expectation(description: "Queue message if not connected then dispatch it")
        self.websocket.shouldAutoConnect = false
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        self.websocket.delegate = TestWebSocketDelegate(expectation: expectation)
        XCTAssertNil(self.websocket.didWriteData)
        self.websocket.shouldAutoConnect = true
        self.websocket.connect()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(self.websocket.didWriteData)
    }

    func testLeaveChannelWritesLeaveData() {
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        self.websocket.didWriteData = nil
        XCTAssertNil(self.websocket.didWriteData)
        self.socketClient.leaveChannel(withTopic: "a_topic")
        XCTAssertNotNil(self.websocket.didWriteData)
    }

    func testDisconnectIfNoChannelIsActive() {
        self.socketClient.joinChannel(withTopic: "a_topic", dispatcher: nil)
        XCTAssertTrue(self.websocket.isConnected)
        self.socketClient.leaveChannel(withTopic: "a_topic")
        XCTAssertNotNil(self.websocket.didWriteData)
        self.websocket.simulateReply()
        XCTAssertFalse(self.websocket.isConnected)
    }
}
