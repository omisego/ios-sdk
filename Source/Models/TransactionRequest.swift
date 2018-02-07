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
public struct TransactionRequest {

    public let id: String
    public let type: TransactionRequestType
    public let mintedTokenId: String
    public let amount: Double?
    public let address: String?
    public let correlationId: String?
    public let consumeURL: String
}

extension TransactionRequest: Codable {

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case mintedTokenId = "token_id"
        case amount
        case address
        case correlationId = "correlation_id"
        case consumeURL = "consume_url"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(mintedTokenId, forKey: .mintedTokenId)
        try container.encode(amount, forKey: .amount)
        try container.encode(address, forKey: .address)
        try container.encode(consumeURL, forKey: .consumeURL)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(TransactionRequestType.self, forKey: .type)
        mintedTokenId = try container.decode(String.self, forKey: .mintedTokenId)
        amount = try container.decode(Double.self, forKey: .amount)
        address = try container.decode(String.self, forKey: .address)
        correlationId = try container.decode(String.self, forKey: .correlationId)
        consumeURL = try container.decode(String.self, forKey: .consumeURL)
    }

}

extension TransactionRequest {

    func qrImage(withSize size: CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
        guard let data = self.id.data(using: .isoLatin1) else { return nil }
        return QRCode.generateQRCode(fromData: data, outputSize: size)
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
