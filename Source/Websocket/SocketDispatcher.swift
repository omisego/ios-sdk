//
//  SocketDispatcher.swift
//  OmiseGO
//
//  Created by Mederic Petit on 19/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

enum SocketDispatcher {

    case user(handler: UserEventHandler)
    case transactionRequest(handler: TransactionRequestEventHandler)
    case transactionConsume(handler: TransactionConsumeEventHandler)

    var commonHandler: EventHandler {
        switch self {
        case .user(let handler): return handler
        case .transactionRequest(let handler): return handler
        case .transactionConsume(let handler): return handler
        }
    }


    func dispatchJoin() {
        self.commonHandler.didStartListening()
    }

    func dispatchLeave() {
        self.commonHandler.didStopListening()
    }

    func dispatchError(_ error: OmiseGOError) {
        self.commonHandler.didReceiveError(error)
    }

    func dispatch(_ payload: GenericObjectEnum, event: SocketEventReceive) {
        switch self {
        case .user(let handler): self.handleUserEvents(withHandler: handler, payload: payload, event: event)
        case .transactionRequest(let handler): self.handleTransactionRequestEvents(withHandler: handler, payload: payload)
        case .transactionConsume(let handler): self.handleTransactionConsumeEvents(withHandler: handler, payload: payload)
        }
    }

    private func handleUserEvents(withHandler handler: UserEventHandler, payload: GenericObjectEnum, event: SocketEventReceive) {
        switch payload {
        case .transactionConsumption(object: let object):
            handler.didReceive(.transactionConsumption(object: object), forEvent: event)
        case .error(error: let error):
            self.dispatchError(error)
        default: break
        }
    }

    private func handleTransactionRequestEvents(withHandler handler: TransactionRequestEventHandler, payload: GenericObjectEnum) {
        switch payload {
        case .transactionConsumption(object: let transactionConsume):
            handler.didReceiveTransactionConsumeRequest(transactionConsume)
        case .error(error: let error):
            self.dispatchError(error)
        default: break
        }
    }

    private func handleTransactionConsumeEvents(withHandler handler: TransactionConsumeEventHandler, payload: GenericObjectEnum) {
        switch payload {
        case .transactionConsumption(object: let transactionConsume):
            handler.didReceiveTransactionConsumeConfirmation(transactionConsume)
        case .error(error: let error):
            self.dispatchError(error)
        default: break
        }
    }

}
