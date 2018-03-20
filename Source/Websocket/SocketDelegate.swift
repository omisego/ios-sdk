//
//  SocketDelegate.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

public protocol SocketConnectionDelegate: class {
    func didConnect()
    func didDisconnect(_ error: OmiseGOError?)
}

public protocol EventDelegate: class {
    func didStartListening()
    func didStopListening()
    func didReceiveError(_ error: OmiseGOError)
}

public protocol UserEventDelegate: EventDelegate {
    func didReceive(_ object: WebsocketObject, forEvent event: SocketEvent)
}

public protocol TransactionRequestEventDelegate: EventDelegate {
    func didReceiveTransactionConsumptionRequest(_ transactionConsumption: TransactionConsumption, forEvent event: SocketEvent)
}

public protocol TransactionConsumptionEventDelegate: EventDelegate {
    func didReceiveTransactionConsumptionConfirmation(_ transactionConsumption: TransactionConsumption, forEvent event: SocketEvent)
}