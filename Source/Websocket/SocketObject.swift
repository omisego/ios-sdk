//
//  SocketObject.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/3/18.
//  Copyright © 2018 Omise Go Pte. Ltd. All rights reserved.
//

public enum WebsocketObject {
    case transactionConsumption(object: TransactionConsume)
}

enum GenericObjectEnum {

    case transactionConsumption(object: TransactionConsume)
    case error(error: OmiseGOError)
    case other(object: [String: Any])

    init?(objectType: String?, decoder: Decoder) throws {
        guard let objectType = objectType else {
            self = .other(object: [:])
            return
        }
        switch objectType {
        case "error":
            self = .error(error: try OmiseGOError.api(apiError: APIError(from: decoder)))
        case "transaction_request_consumption":
            self = .transactionConsumption(object: try TransactionConsume(from: decoder))
        default: return nil
        }
    }
}

extension GenericObjectEnum: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        switch self {
        case .other(object: let object):
            try container.encodeJSONDictionary(object)
        default: try container.encodeJSONDictionary([:])
        }
    }

}

struct GenericObject {

    let object: GenericObjectEnum

}

extension GenericObject: Codable {

    private enum CodingKeys: String, CodingKey {
        case objectType = "object"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let objectType: String? = try container.decodeIfPresent(String.self, forKey: .objectType)
        guard let decodedObject = try GenericObjectEnum(objectType: objectType, decoder: decoder) else {
            throw OmiseGOError.socketError(message: "Unknown object type")
        }
        self.object = decodedObject
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(object)
    }

}
