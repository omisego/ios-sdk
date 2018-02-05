//
//  TransactionRequest.swift
//  OmiseGO
//
//  Created by Mederic Petit on 5/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//
// swiftlint:disable identifier_name

public enum TransactionRequestType: String, Codable {
    case send
    case receive
}

/// Represents a transaction request
public struct TransactionRequest: Decodable {

    public let id: String
    public let type: TransactionRequestType
    public let mintedTokenId: String
    public let amount: Double?
    public let providerUserId: String
    public let balanceId: String
    public let correlationId: String
    public let serviceEndpoint: String

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case mintedTokenId = "minted_token_id"
        case amount
        case providerUserId = "provider_user_id"
        case balanceId = "balance_id"
        case correlationId = "correlation_id"
        case serviceEndpoint = "service_endpoint"
    }

}

extension TransactionRequest: Retrievable {

    @discardableResult
    /// Generate a transaction request from the given TransactionRequestParams object
    ///
    /// - Parameters:
    ///   - client: An API client.
    ///             This client need to be initialized with a OMGConfiguration struct before being used.
    ///   - params: The TransactionRequestParams object describing the transaction request to be made.
    ///   - callback: The closure called when the request is completed
    /// - Returns: An optional cancellable request.
    public static func generateTransactionRequest(using client: OMGClient,
                                                  params: TransactionRequestParams,
                                                  callback: @escaping TransactionRequest.RetrieveRequestCallback)
                                                    -> TransactionRequest.RetrieveRequest? {
        return self.retrieve(using: client, endpoint: .transactionRequestCreate(params: params), callback: callback)
    }

}

extension TransactionRequest: Hashable {

    public var hashValue: Int {
        return self.id.hashValue
    }

}

// MARK: Equatable

public func == (lhs: TransactionRequest, rhs: TransactionRequest) -> Bool {
    return lhs.id == rhs.id
}

