//
//  Listenable.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//

public protocol Listenable {
    var webSocketURL: String { get }
    func stopListening()
}

public extension Listenable {
    public func stopListening() {
        SocketWrapper.shared.disconnectSocket(withURL: self.webSocketURL)
    }
}

public extension Listenable where Self == User {

    public func startListeningEvents(withHandler handler: UserEventHandler) {
        SocketWrapper.shared.connect(toURL: URL(string: webSocketURL)!,
                                     handler: handler,
                                     onDecode: { handler.didReceive($0)})
    }
}


public extension Listenable where Self == TransactionRequest {

    public func startListeningEvents(withHandler handler: TransactionRequestEventHandler) {
        SocketWrapper.shared.connect(toURL: URL(string: webSocketURL)!,
                                     handler: handler,
                                     onDecode: { webSocketObject in
                                        switch webSocketObject.event {
                                        case .transactionConsumptionRequest(object: let transactionConsume):
                                            handler.didReceiveTransactionConsumeRequest(transactionConsume)
                                        default: break
                                        }
        })
    }

}

public extension Listenable where Self == TransactionConsume {

    public func startListeningEvents(withHandler handler: TransactionConsumeEventHandler) {
        SocketWrapper.shared.connect(toURL: URL(string: webSocketURL)!,
                                     handler: handler,
                                     onDecode: { webSocketObject in
                                        switch webSocketObject.event {
                                        case .transactionConsumptionRequest(object: let transactionConsume):
                                            handler.didReceiveTransactionConsumeConfirmation(transactionConsume)
                                        default: break
                                        }
        })
    }

}
