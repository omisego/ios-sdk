//
//  TransactionConsumption.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 13/2/2018.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// The status of a transaction consumption
///
/// - pending: The transaction consumption is pending validation
/// - confirmed: The transaction was consumed
/// - failed: The transaction failed to be consumed
public enum TransactionConsumptionStatus: String, Decodable {
    case pending
    case confirmed
    case failed
}

/// Represents a transaction consumption
public struct TransactionConsumption: Listenable, Decodable {

    public let id: String
    public let status: TransactionConsumptionStatus
    public let amount: Double
    public let mintedToken: MintedToken
    public let correlationId: String?
    public let idempotencyToken: String
    public let transactionId: String?
    public let userId: String
    public let transactionRequestId: String
    public let address: String
    public let socketTopic: String

    private enum CodingKeys: String, CodingKey {
        case id
        case status
        case amount
        case mintedToken = "minted_token"
        case correlationId = "correlation_id"
        case idempotencyToken = "idempotency_token"
        case transactionId = "transaction_id"
        case userId = "user_id"
        case transactionRequestId = "transaction_request_id"
        case address
        case socketTopic = "socket_topic"
    }

}

extension TransactionConsumption: Retrievable {

    @discardableResult
    /// Consume a transaction request from the given TransactionConsumptionParams object
    ///
    /// - Parameters:
    ///   - client: An API client.
    ///             This client need to be initialized with a OMGConfiguration struct before being used.
    ///   - params: The TransactionConsumptionParams object describing the transaction request to be consumed.
    ///   - callback: The closure called when the request is completed
    /// - Returns: An optional cancellable request.
    public static func consumeTransactionRequest(using client: OMGClient,
                                                 params: TransactionConsumptionParams,
                                                 callback: @escaping TransactionConsumption.RetrieveRequestCallback)
        -> TransactionConsumption.RetrieveRequest? {
            return self.retrieve(using: client,
                                 endpoint: .transactionRequestConsume(params: params),
                                 callback: callback)
    }

}

extension TransactionConsumption: Hashable {

    public var hashValue: Int {
        return self.id.hashValue
    }

    public static func == (lhs: TransactionConsumption, rhs: TransactionConsumption) -> Bool {
        return lhs.id == rhs.id
    }

}
