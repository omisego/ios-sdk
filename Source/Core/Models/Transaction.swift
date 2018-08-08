//
//  Transaction.swift
//  OmiseGO
//
//  Created by Mederic Petit on 23/2/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// The status of a transaction
///
/// - pending: The transaction is pending
/// - confirmed: The transaction is confirmed
/// - failed: The transaction failed
public enum TransactionStatus: String, Decodable {
    case pending
    case confirmed
    case failed
}

/// Represents a transaction between 2 addresses
public struct Transaction {
    /// The unique identifier of the transaction
    public let id: String
    /// The status of the transaction (pending, confirmed or failed)
    public let status: TransactionConsumptionStatus
    /// The source reprensenting the source of the funds
    public let from: TransactionSource
    /// The source representing the destination of the funds
    public let to: TransactionSource
    /// Contains info of the exchange made during the transaction (if any)
    public let exchange: TransactionExchange
    /// Additional metadata for the consumption
    public let metadata: [String: Any]
    /// Additional encrypted metadata for the consumption
    public let encryptedMetadata: [String: Any]
    /// The creation date of the transaction
    public let createdAt: Date
    /// An APIError object if the transaction encountered an error
    public let error: APIError?
}

extension Transaction: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case status
        case from
        case to
        case exchange
        case metadata
        case encryptedMetadata = "encrypted_metadata"
        case createdAt = "created_at"
        case errorCode = "error_code"
        case errorDescription = "error_description"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        status = try container.decode(TransactionConsumptionStatus.self, forKey: .status)
        from = try container.decode(TransactionSource.self, forKey: .from)
        to = try container.decode(TransactionSource.self, forKey: .to)
        exchange = try container.decode(TransactionExchange.self, forKey: .exchange)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        metadata = try container.decode([String: Any].self, forKey: .metadata)
        encryptedMetadata = try container.decode([String: Any].self, forKey: .encryptedMetadata)
        if let code = try container.decodeIfPresent(APIErrorCode.self, forKey: .errorCode),
            let description = try container.decodeIfPresent(String.self, forKey: .errorDescription) {
            self.error = APIError(code: code, description: description)
        } else {
            self.error = nil
        }
    }
}

extension Transaction: Paginable {
    public enum SearchableFields: String, KeyEncodable {
        case id
        case status
        case from
        case to
    }

    public enum SortableFields: String, KeyEncodable {
        case id
        case status
        case from
        case to
        case createdAt = "created_at"
    }
}

extension Transaction: Hashable {
    public var hashValue: Int {
        return self.id.hashValue
    }

    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.id == rhs.id
    }
}
