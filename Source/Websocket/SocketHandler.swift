//
//  SocketHandler.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

public protocol EventHandler {
    func didStartListening()
    func didStopListening()
    func didReceiveError(_ error: OmiseGOError)
}

public protocol UserEventHandler: EventHandler {
    func didReceive(_ object: WebsocketObject, forEvent event: SocketEvent)
}

public protocol TransactionRequestEventHandler: EventHandler {
    func didReceiveTransactionConsumptionRequest(_ transactionConsumption: TransactionConsumption, forEvent event: SocketEvent)
}

public protocol TransactionConsumptionEventHandler: EventHandler {
    func didReceiveTransactionConsumptionConfirmation(_ transactionConsumption: TransactionConsumption, forEvent event: SocketEvent)
}
