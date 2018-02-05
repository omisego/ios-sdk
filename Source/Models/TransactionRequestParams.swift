//
//  TransactionRequestParams.swift
//  OmiseGO
//
//  Created by Mederic Petit on 5/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

/// Represents a structure used to generate a transaction request
public struct TransactionRequestParams: Parametrable {

    public let type: TransactionRequestType
    public let mintedTokenId: String
    public let amount: Double?
    public let providerUserId: String
    public let balanceId: String?
    public let correlationId: String

    private enum CodingKeys: String, CodingKey {
        case type
        case mintedTokenId = "minted_token_id"
        case amount
        case providerUserId = "provider_user_id"
        case balanceId = "balance_id"
        case correlationId = "correlation_id"
    }

    func encodedPayload() -> Data? {
        return try? JSONEncoder().encode(self)
    }

}
