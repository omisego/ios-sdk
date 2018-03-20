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
        client.websocket.leaveChannel(withTopic: self.socketTopic)
    }
}

public extension Listenable where Self == User {

    public func startListeningEvents(withClient client: OMGClient, eventDelegate: UserEventDelegate) {
        client.websocket.join(withTopic: self.socketTopic, dispatcher: SocketDispatcher.user(handler: eventDelegate))
    }

}

public extension Listenable where Self == TransactionRequest {

    public func startListeningEvents(withClient client: OMGClient, eventDelegate: TransactionRequestEventDelegate) {
        client.websocket.join(withTopic: self.socketTopic, dispatcher: SocketDispatcher.transactionRequest(handler: eventDelegate))
    }

}

public extension Listenable where Self == TransactionConsumption {

    public func startListeningEvents(withClient client: OMGClient, eventDelegate: TransactionConsumptionEventDelegate) {
        client.websocket.join(withTopic: self.socketTopic, dispatcher: SocketDispatcher.transactionConsumption(handler: eventDelegate))
    }

}
