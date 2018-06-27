//
//  TransactionParams.swift
//  OmiseGO
//
//  Created by Mederic Petit on 21/5/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import BigInt

/// Represents a structure used to create a transaction
public struct TransactionCreateParams {

    /// The address from which to take the tokens (which must belong to the user).
    /// If not specified, the user's primary balance will be used.
    public let fromAddress: String?
    /// The amount of token to send (down to subunit to unit)
    public let fromAmount: BigInt?
    /// The id of the token that will be used to send the funds
    public let fromTokenId: String
    /// The address where to send the tokens
    public let toAddress: String?
    /// The account id where to send the tokens
    public let toAccountId: String?
    /// The user id where to send the token
    public let toUserId: String?
    /// The amount of token that the recipient should receive (down to subunit to unit)
    public let toAmount: BigInt?
    /// The id of the token that will be used to receive the funds
    public let toTokenId: String
    /// Additional metadata for the transaction
    public let metadata: [String: Any]
    /// Additional encrypted metadata for the transaction
    public let encryptedMetadata: [String: Any]

    private init(fromAddress: String?,
                 fromAmount: BigInt?,
                 fromTokenId: String,
                 toAddress: String?,
                 toAccountId: String?,
                 toUserId: String?,
                 toAmount: BigInt?,
                 toTokenId: String,
                 metadata: [String: Any],
                 encryptedMetadata: [String: Any]) {
        self.fromAddress = fromAddress
        self.fromAmount = fromAmount
        self.fromTokenId = fromTokenId
        self.toAddress = toAddress
        self.toAccountId = toAccountId
        self.toUserId = toUserId
        self.toAmount = toAmount
        self.toTokenId = toTokenId
        self.metadata = metadata
        self.encryptedMetadata = encryptedMetadata
    }

    public init(fromAddress: String? = nil,
                fromAmount: BigInt,
                fromTokenId: String,
                toAddress: String,
                toAmount: BigInt? = nil,
                toTokenId: String,
                metadata: [String: Any] = [:],
                encryptedMetadata: [String: Any] = [:]) {
        self.init(fromAddress: fromAddress,
                  fromAmount: fromAmount,
                  fromTokenId: fromTokenId,
                  toAddress: toAddress,
                  toAccountId: nil,
                  toUserId: nil,
                  toAmount: toAmount,
                  toTokenId: toTokenId,
                  metadata: metadata,
                  encryptedMetadata: encryptedMetadata)
    }

    public init(fromAddress: String? = nil,
                fromAmount: BigInt? = nil,
                fromTokenId: String,
                toAddress: String,
                toAmount: BigInt,
                toTokenId: String,
                metadata: [String: Any] = [:],
                encryptedMetadata: [String: Any] = [:]) {
        self.init(fromAddress: fromAddress,
                  fromAmount: fromAmount,
                  fromTokenId: fromTokenId,
                  toAddress: toAddress,
                  toAccountId: nil,
                  toUserId: nil,
                  toAmount: toAmount,
                  toTokenId: toTokenId,
                  metadata: metadata,
                  encryptedMetadata: encryptedMetadata)
    }

    public init(fromAddress: String? = nil,
                fromAmount: BigInt,
                fromTokenId: String,
                toAccountId: String,
                toAmount: BigInt? = nil,
                toTokenId: String,
                metadata: [String: Any] = [:],
                encryptedMetadata: [String: Any] = [:]) {
        self.init(fromAddress: fromAddress,
                  fromAmount: fromAmount,
                  fromTokenId: fromTokenId,
                  toAddress: nil,
                  toAccountId: toAccountId,
                  toUserId: nil,
                  toAmount: toAmount,
                  toTokenId: toTokenId,
                  metadata: metadata,
                  encryptedMetadata: encryptedMetadata)
    }

    public init(fromAddress: String? = nil,
                fromAmount: BigInt? = nil,
                fromTokenId: String,
                toAccountId: String,
                toAmount: BigInt,
                toTokenId: String,
                metadata: [String: Any] = [:],
                encryptedMetadata: [String: Any] = [:]) {
        self.init(fromAddress: fromAddress,
                  fromAmount: fromAmount,
                  fromTokenId: fromTokenId,
                  toAddress: nil,
                  toAccountId: toAccountId,
                  toUserId: nil,
                  toAmount: toAmount,
                  toTokenId: toTokenId,
                  metadata: metadata,
                  encryptedMetadata: encryptedMetadata)
    }

    public init(fromAddress: String? = nil,
                fromAmount: BigInt,
                fromTokenId: String,
                toUserId: String,
                toAmount: BigInt? = nil,
                toTokenId: String,
                metadata: [String: Any] = [:],
                encryptedMetadata: [String: Any] = [:]) {
        self.init(fromAddress: fromAddress,
                  fromAmount: fromAmount,
                  fromTokenId: fromTokenId,
                  toAddress: nil,
                  toAccountId: nil,
                  toUserId: toUserId,
                  toAmount: toAmount,
                  toTokenId: toTokenId,
                  metadata: metadata,
                  encryptedMetadata: encryptedMetadata)
    }

    public init(fromAddress: String? = nil,
                fromAmount: BigInt? = nil,
                fromTokenId: String,
                toUserId: String,
                toAmount: BigInt,
                toTokenId: String,
                metadata: [String: Any] = [:],
                encryptedMetadata: [String: Any] = [:]) {
        self.init(fromAddress: fromAddress,
                  fromAmount: fromAmount,
                  fromTokenId: fromTokenId,
                  toAddress: nil,
                  toAccountId: nil,
                  toUserId: toUserId,
                  toAmount: toAmount,
                  toTokenId: toTokenId,
                  metadata: metadata,
                  encryptedMetadata: encryptedMetadata)
    }

}

extension TransactionCreateParams: APIParameters {

    private enum CodingKeys: String, CodingKey {
        case fromAddress = "from_address"
        case fromAmount = "from_amount"
        case fromTokenId = "from_token_id"
        case toAddress = "to_address"
        case toAccountId = "to_account_id"
        case toUserId = "to_user_id"
        case toAmount = "to_amount"
        case toTokenId = "to_token_id"
        case metadata
        case encryptedMetadata = "encrypted_metadata"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fromAddress, forKey: .fromAddress)
        try container.encode(fromAmount, forKey: .fromAmount)
        try container.encode(fromTokenId, forKey: .fromTokenId)
        try container.encode(toAddress, forKey: .toAddress)
        try container.encode(toAccountId, forKey: .toAccountId)
        try container.encode(toUserId, forKey: .toUserId)
        try container.encode(toAmount, forKey: .toAmount)
        try container.encode(toTokenId, forKey: .toTokenId)
        try container.encode(metadata, forKey: .metadata)
        try container.encode(encryptedMetadata, forKey: .encryptedMetadata)
    }

}
