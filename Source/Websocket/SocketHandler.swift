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
    func didReceive(_ object: WebsocketObject, forEvent event: SocketEventReceive)
}

public protocol TransactionRequestEventHandler: EventHandler {
    func didReceiveTransactionConsumeRequest(_ transactionConsume: TransactionConsume)
}

public protocol TransactionConsumeEventHandler: EventHandler {
    func didReceiveTransactionConsumeConfirmation(_ transactionConsume: TransactionConsume)
}
