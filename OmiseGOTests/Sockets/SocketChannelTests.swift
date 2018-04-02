//
//  SocketChannelTests.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 22/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

import XCTest
@testable import OmiseGO

class DummySendable: SocketSendable {

    var topic: String?
    var event: SocketEventSend?
    var didSend: Bool = false

    var message: SocketMessage!

    func send(topic: String, event: SocketEventSend) -> SocketMessage {
        self.topic = topic
        self.event = event
        self.didSend = true
        let payloadSend = SocketPayloadSend(topic: topic, event: event, ref: "1", data: [:])
        let message = SocketMessage(socketPayload: payloadSend)
        self.message = message
        return message
    }

    func triggerEvents(withPayload payload: SocketPayloadReceive) {
        self.message.handleResponse(withPayload: payload)
    }

}

class SocketChannelTests: XCTestCase {

    var socketChannel: SocketChannel!
    var sendable: DummySendable!
    var delegate: DummySocketEventDelegate!

    override func setUp() {
        super.setUp()
        self.sendable = DummySendable()
        self.delegate = DummySocketEventDelegate()
        let dispatcher = SocketDispatcher.user(handler: self.delegate)
        self.socketChannel = SocketChannel(topic: "a_topic", socket: self.sendable, dispatcher: dispatcher)
    }

    func testJoinSendsAJoinEvent() {
        self.socketChannel.join()
        XCTAssertTrue(self.sendable.didSend)
        XCTAssertEqual(self.sendable.topic, "a_topic")
        XCTAssertEqual(self.sendable.event, SocketEventSend.join)
    }

    func testJoinDispatchesAJoinEventOnSuccess() {
        self.socketChannel.join()
        self.sendable.triggerEvents(withPayload: self.successPayload())
        XCTAssertTrue(self.delegate.didJoin)
        XCTAssertNil(self.delegate.didReceiveObject)
        XCTAssertNil(self.delegate.didReceiveError)
        XCTAssertNil(self.delegate.didReceiveEvent)
    }

    func testJoinDoesntDispatchesAJoinEventOnFailure() {
        self.socketChannel.join()
        self.sendable.triggerEvents(withPayload: self.failurePayload())
        XCTAssertFalse(self.delegate.didJoin)
        XCTAssertNil(self.delegate.didReceiveObject)
        XCTAssertNil(self.delegate.didReceiveError)
        XCTAssertNil(self.delegate.didReceiveEvent)
    }

    func testLeaveSendsALeaveEvent() {
        self.socketChannel.leave {}
        XCTAssertTrue(self.sendable.didSend)
        XCTAssertEqual(self.sendable.topic, "a_topic")
        XCTAssertEqual(self.sendable.event, SocketEventSend.leave)
    }

    func testLeaveDispatchesALeaveEventOnSuccess() {
        let expectation = self.expectation(description: "Callback is called")
        self.socketChannel.leave {
            expectation.fulfill()
        }
        self.sendable.triggerEvents(withPayload: self.successPayload())
        XCTAssertTrue(self.delegate.didLeave)
        XCTAssertNil(self.delegate.didReceiveObject)
        XCTAssertNil(self.delegate.didReceiveError)
        XCTAssertNil(self.delegate.didReceiveEvent)
        self.waitForExpectations(timeout: 1, handler: nil)
    }

    func testLeaveDoesntDispatchesALeaveEventOnFailure() {
        self.socketChannel.leave {
            XCTFail("Should not call this closure")
        }
        self.sendable.triggerEvents(withPayload: self.failurePayload())
        XCTAssertFalse(self.delegate.didLeave)
        XCTAssertNil(self.delegate.didReceiveObject)
        XCTAssertNil(self.delegate.didReceiveError)
        XCTAssertNil(self.delegate.didReceiveEvent)
    }

    func testDispatchEventsToSuccessHandlerOnSuccess() {
        let message = SocketMessage(socketPayload: SocketPayloadSend(topic: "a_topic", event: .join, ref: "1", data: [:]))
        message.handleResponse(withPayload: self.successPayload())
        self.socketChannel.dispatchEvents(message)
        XCTAssertNotNil(self.delegate.didReceiveObject)
        switch self.delegate.didReceiveObject! {
        case .transactionConsumption(object: let transactionConsumption): XCTAssertNotNil(transactionConsumption)
        }
    }

    func testDispatchEventsToErrorHandlerHandlerOnFailure() {
        let message = SocketMessage(socketPayload: SocketPayloadSend(topic: "a_topic", event: .join, ref: "1", data: [:]))
        message.handleResponse(withPayload: self.failurePayload())
        self.socketChannel.dispatchEvents(message)
        XCTAssertEqual(self.delegate.didReceiveError!.message, "socket error: dummy error")
    }

    private func failurePayload() -> SocketPayloadReceive {
        return StubGenerator.socketPayloadReceive(data: GenericObject.init(object: .error(error: .socketError(message: "dummy error"))),
                                                  success: false)
    }

    private func successPayload() -> SocketPayloadReceive {
        return StubGenerator.socketPayloadReceive()
    }

}
