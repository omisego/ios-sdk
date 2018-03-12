//
//  Listenable.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//

public protocol Listenable {
    var socketTopic: String { get }
}

public extension Listenable {
    public func stopListening(withClient client: OMGClient) {
        client.socketManager.leaveChannel(withTopic: self.socketTopic)
    }
}

public extension Listenable where Self == User {

    public func startListeningEvents(withClient client: OMGClient, handler: UserEventHandler) {
        client.socketManager.join(withTopic: self.socketTopic, dispatcher: SocketDispatcher.user(handler: handler))
    }

}

public extension Listenable where Self == TransactionRequest {

    public func startListeningEvents(withClient client: OMGClient, handler: TransactionRequestEventHandler) {
        client.socketManager.join(withTopic: self.socketTopic, dispatcher: SocketDispatcher.transactionRequest(handler: handler))
    }

}

public extension Listenable where Self == TransactionConsume {

    public func startListeningEvents(withClient client: OMGClient, handler: TransactionConsumeEventHandler) {
        client.socketManager.join(withTopic: self.socketTopic, dispatcher: SocketDispatcher.transactionConsume(handler: handler))
    }

}
