//
//  TransactionRequestParams.swift
//  OmiseGO
//
//  Created by Mederic Petit on 5/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

/// Represents a structure used to generate a transaction request
public struct TransactionRequestParams {

    public let type: TransactionRequestType
    public let mintedTokenId: String
    public let amount: Double?
    public let address: String?
    public let correlationId: String?

}

extension TransactionRequestParams: Parametrable {

    private enum CodingKeys: String, CodingKey {
        case type
        case mintedTokenId = "minted_token_id"
        case amount
        case address
        case correlationId = "correlation_id"
    }

    func encodedPayload() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    // Custom encoding as we need to encode amount event if nil
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(mintedTokenId, forKey: .mintedTokenId)
        try container.encode(amount, forKey: .amount)
        try container.encode(address, forKey: .address)
        try container.encode(correlationId, forKey: .correlationId)
    }

}
