//
//  SocketHandler.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//  Copyright © 2018 Omise Go Ptd. Ltd. All rights reserved.
//

public protocol EventHandler {
    func didDisconnect()
    func didConnect()
    func didReceiveError(_ error: OmiseGOError)
}

public protocol UserEventHandler: EventHandler {
    func didReceive(_ webSocketObject: WebSocketObject)
}

public protocol TransactionRequestEventHandler: EventHandler {
    func didReceiveTransactionConsumeRequest(_ transactionConsume: TransactionConsume)
}

public protocol TransactionConsumeEventHandler: EventHandler {
    func didReceiveTransactionConsumeConfirmation(_ transactionConsume: TransactionConsume)
}
