//
//  SocketWrapper.swift
//  OmiseGO
//
//  Created by Mederic Petit on 8/3/18.
//  Copyright © 2018 Omise Go Ptd. Ltd. All rights reserved.
//

import Starscream

typealias OnDecodeClosure = (_ : WebSocketObject) -> Void

class SocketWrapper {

    static let shared = SocketWrapper()

    var sockets: [WebSocket] = []

    func connect(toURL url: URL, handler: EventHandler, onDecode: @escaping OnDecodeClosure) {
        let socket = WebSocket(url: url)
        self.sockets.append(socket)
        socket.onDisconnect = { [weak self] error in
            self?.removeSocket(socket)
            handler.didDisconnect()
        }
        socket.onText = { [weak self] text in
            self?.handleMessage(text, handler: handler, onDecode: onDecode)
        }
        socket.onConnect = {
            handler.didConnect()
//            socket.write(data: try! Data.init(contentsOf: URL(string: "https://www.dl.dropboxusercontent.com/s/2s57k7r6qdok4vv/transaction_consumption_request.json")! , options: Data.ReadingOptions.uncached))
        }
        socket.onData = { [weak self] data in
            self?.handleData(data, handler: handler, onDecode: onDecode)
        }
        socket.connect()
    }

    func disconnectSocket(withURL url: String) {
        self.sockets.filter({ $0.currentURL.absoluteString == url }).first?.disconnect()
    }

    private func removeSocket(_ s: WebSocket?) {
        self.sockets = self.sockets.filter { $0 != s }
    }

    private func handleData(_ data: Data, handler: EventHandler, onDecode: OnDecodeClosure) {
        guard let decodedWebSocketObject: OMGJSONResponse<WebSocketObject> = try? deserializeData(data)
            else {
                handler.didReceiveError(.socketError(message: "Received unexpected message"))
                return
        }
        switch decodedWebSocketObject.data {
        case .success(data: let object):
            onDecode(object)
        case .fail(error: let error):
            handler.didReceiveError(error)
        }
    }

    private func handleMessage(_ text: String, handler: EventHandler, onDecode: OnDecodeClosure) {
        guard let data = text.data(using: .utf8)
        else {
            handler.didReceiveError(.socketError(message: "Received unexpected message"))
            return
        }
        self.handleData(data, handler: handler, onDecode: onDecode)
    }

}
