//
//  ExchangePair.swift
//  OmiseGO
//
//  Created by Mederic Petit on 29/6/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import UIKit

public struct ExchangePair {

    public let id: String
    public let name: String
    public let fromTokenId: String
    public let fromToken: Token
    public let toTokenId: String
    public let toToken: Token
    public let rate: Double
    public let createdAt: Date
    public let updatedAt: Date

}

extension ExchangePair: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fromTokenId = "from_token_id"
        case fromToken = "from_token"
        case toTokenId = "to_token_id"
        case toToken = "to_token"
        case rate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        fromTokenId = try container.decode(String.self, forKey: .fromTokenId)
        fromToken = try container.decode(Token.self, forKey: .fromToken)
        toTokenId = try container.decode(String.self, forKey: .toTokenId)
        toToken = try container.decode(Token.self, forKey: .toToken)
        rate = try container.decode(Double.self, forKey: .rate)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }

}
