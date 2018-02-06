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

    static let isQRCodeEncoding = CodingUserInfoKey(rawValue: "isQRCodeEncoding")!

    public let id: String
    public let type: TransactionRequestType
    public let mintedTokenId: String
    public let amount: Double?
    public let providerUserId: String?
    public let address: String?
    public let correlationId: String?
    public let serviceEndpoint: String
}

extension TransactionRequest: Codable {

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case mintedTokenId = "minted_token_id"
        case amount
        case providerUserId = "provider_user_id"
        case address
        case correlationId = "correlation_id"
        case serviceEndpoint = "service_endpoint"
    }

    private enum QRCodeCodingKeys: String, CodingKey {
        case id
        case type = "ty"
        case mintedTokenId = "mtid"
        case amount = "am"
        case serviceEndpoint = "se"
    }

    public func encode(to encoder: Encoder) throws {
        if let isQRCodeEncoding: Bool = encoder.userInfo[TransactionRequest.isQRCodeEncoding] as? Bool,
            isQRCodeEncoding == true {
            var container = encoder.container(keyedBy: QRCodeCodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(type, forKey: .type)
            try container.encode(mintedTokenId, forKey: .mintedTokenId)
            try container.encode(amount, forKey: .amount)
            try container.encode(serviceEndpoint, forKey: .serviceEndpoint)
        } else {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(type, forKey: .type)
            try container.encode(mintedTokenId, forKey: .mintedTokenId)
            try container.encode(amount, forKey: .amount)
            try container.encode(providerUserId, forKey: .providerUserId)
            try container.encode(address, forKey: .address)
            try container.encode(serviceEndpoint, forKey: .serviceEndpoint)
        }
    }

    public init(from decoder: Decoder) throws {
        if let isQRCodeEncoding: Bool = decoder.userInfo[TransactionRequest.isQRCodeEncoding] as? Bool,
            isQRCodeEncoding == true {
            let container = try decoder.container(keyedBy: QRCodeCodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            type = try container.decode(TransactionRequestType.self, forKey: .type)
            mintedTokenId = try container.decode(String.self, forKey: .mintedTokenId)
            amount = try container.decode(Double.self, forKey: .amount)
            providerUserId = nil
            address = nil
            correlationId = nil
            serviceEndpoint = try container.decode(String.self, forKey: .serviceEndpoint)
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            type = try container.decode(TransactionRequestType.self, forKey: .type)
            mintedTokenId = try container.decode(String.self, forKey: .mintedTokenId)
            amount = try container.decode(Double.self, forKey: .amount)
            providerUserId = try container.decode(String.self, forKey: .providerUserId)
            address = try container.decode(String.self, forKey: .address)
            correlationId = try container.decode(String.self, forKey: .correlationId)
            serviceEndpoint = try container.decode(String.self, forKey: .serviceEndpoint)
        }
    }

}

extension TransactionRequest {

    func qrImage(withSize size: CGSize = CGSize(width: 200, height: 200)) -> UIImage? {
        do {
            let encoder = JSONEncoder()
            encoder.userInfo[TransactionRequest.isQRCodeEncoding] = true
            let data = try encoder.encode(self)
            return QRCode.generateQRCode(fromData: data, outputSize: size)
        } catch {
            return nil
        }
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
