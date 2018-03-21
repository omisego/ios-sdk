//
//  SocketEvent.swift
//  OmiseGO
//
//  Created by Mederic Petit on 20/3/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

enum SocketEventSend: String, Encodable {
    case heartbeat = "heartbeat"
    case join = "phx_join"
    case leave = "phx_leave"
    case error = "phx_error"
    case close = "phx_close"
}

public enum SocketEvent: String, Decodable {
    case reply = "phx_reply"
    case transactionConsumptionRequest = "transaction_consumption_request"
    case transactionConsumptionConfirmation = "transaction_consumption_confirmation"
}
