//
//  SocketMessage.swift
//  OmiseGO
//
//  Created by Mederic Petit on 12/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

class SocketMessage {

    let dataSent: SocketPayloadSend?
    var dataReceived: SocketPayloadReceive?
    var error: OmiseGOError?
    var receivedResponse: GenericObjectEnum?
    private var errorHandler: ((OmiseGOError) -> Void)?
    private var successHandler: ((GenericObjectEnum) -> Void)?

    init(socketPayload: SocketPayloadSend) {
        self.dataSent = socketPayload
    }

    init(socketPayload: SocketPayloadReceive) {
        self.dataSent = nil
        self.dataReceived = socketPayload
    }

    @discardableResult
    func onSuccess(_ handler: @escaping ((GenericObjectEnum) -> Void)) -> SocketMessage {
        self.successHandler = handler
        return self
    }

    @discardableResult
    func onError(_ handler: @escaping ((OmiseGOError) -> Void)) -> SocketMessage {
        self.errorHandler = handler
        return self
    }

    func topic() -> String {
        return self.dataSent?.topic ?? self.dataReceived?.topic ?? "undefined"
    }

    func handleResponse(withPayload payload: SocketPayloadReceive) {
        self.dataReceived = payload
        switch payload.data.object {
        case .error(error: let error): self.error = error
        default: self.receivedResponse = payload.data.object
        }
        self.fireCallbacksAndCleanup()
    }

    private func fireCallbacksAndCleanup() {
        defer {
            self.errorHandler = nil
            self.successHandler = nil
        }
        if let error = self.error, let errorHandler = self.errorHandler {
            errorHandler(error)
        } else if let object = self.receivedResponse, let successHandler = self.successHandler {
            successHandler(object)
        }
    }

}