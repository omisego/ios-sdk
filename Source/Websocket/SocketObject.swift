//
//  SocketObject.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//  Copyright © 2018 Omise Go Ptd. Ltd. All rights reserved.
//

import Starscream

public enum OmiseGOWebSocketEvent {
    case transactionConsumptionRequest(object: TransactionConsume)
    case transactionConsumptionConfirmation(object: TransactionConsume)
}

public struct WebSocketObject: Decodable {
    public let event: OmiseGOWebSocketEvent

    private enum CodingKeys: String, CodingKey {
        case eventType = "event"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let event: String = try container.decode(String.self, forKey: .eventType)
        switch event {
        case "transaction_consumption_request":
            self.event = .transactionConsumptionRequest(object: try TransactionConsume(from: decoder))
        case "transaction_consumption_confirmation":
            self.event = .transactionConsumptionConfirmation(object: try TransactionConsume(from: decoder))
        default: throw OmiseGOError.socketError(message: "Unknown object type")
        }
    }
}
