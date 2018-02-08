//
//  TransactionConsumeParams.swift
//  OmiseGO
//
//  Created by Mederic Petit on 7/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

/// Represents a structure used to consume a transaction request
public struct TransactionConsumeParams {

    public let transactionRequestId: String
    public let amount: Double
    public let address: String?
    public let idempotencyToken: String

    init?(transactionRequest: TransactionRequest, amount: Double? = nil, idempotencyToken: String) {
        guard let amount = (amount != nil ? amount : transactionRequest.amount) else { return nil }
        self.transactionRequestId = transactionRequest.id
        self.amount = amount
        self.address = transactionRequest.address
        self.idempotencyToken = idempotencyToken
    }

}

extension TransactionConsumeParams: Parametrable {

    private enum CodingKeys: String, CodingKey {
        case transactionRequestId = "transaction_request_id"
        case amount
        case address
    }

    func encodedPayload() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transactionRequestId, forKey: .transactionRequestId)
        try container.encode(amount, forKey: .amount)
        try container.encode(address, forKey: .address)
    }

}
