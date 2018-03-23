//
//  DummySocketEventDelegate.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 22/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

@testable import OmiseGO

class DummySocketEventDelegate {

    var didJoin: Bool = false
    var didLeave: Bool = false
    var didReceiveObject: WebsocketObject?
    var didReceiveTransactionConsumption: TransactionConsumption?
    var didReceiveEvent: SocketEvent?
    var didReceiveError: OmiseGOError?

}

extension DummySocketEventDelegate: UserEventDelegate {

    func didReceive(_ object: WebsocketObject, forEvent event: SocketEvent) {
        self.didReceiveObject = object
        self.didReceiveEvent = event
    }

    func didStartListening() {
        self.didJoin = true
    }

    func didStopListening() {
        self.didLeave = true
    }

    func didReceiveError(_ error: OmiseGOError) {
        self.didReceiveError = error
    }

}

extension DummySocketEventDelegate: TransactionRequestEventDelegate {

    func didReceiveTransactionConsumptionRequest(_ transactionConsumption: TransactionConsumption, forEvent event: SocketEvent) {
        self.didReceiveTransactionConsumption = transactionConsumption
        self.didReceiveEvent = event
    }


}

extension DummySocketEventDelegate: TransactionConsumptionEventDelegate {

    func didReceiveTransactionConsumptionConfirmation(_ transactionConsumption: TransactionConsumption, forEvent event: SocketEvent) {
        self.didReceiveTransactionConsumption = transactionConsumption
        self.didReceiveEvent = event
    }

}
