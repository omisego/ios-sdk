//
//  StubGenerator.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 16/2/2018.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

@testable import OmiseGO

class StubGenerator {

    class func fileContent(forResource resource: String) -> Data {
        let bundle = Bundle(for: StubGenerator.self)
        let directoryURL = bundle.url(forResource: "Fixtures/objects", withExtension: nil)!
        let filePath = (resource as NSString).appendingPathExtension("json")! as String
        let fixtureFileURL = directoryURL.appendingPathComponent(filePath)
        return try! Data(contentsOf: fixtureFileURL)
    }

    private class func stub<T: Decodable>(forResource resource: String) -> T {
        let data = self.fileContent(forResource: resource)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({return try dateDecodingStrategy(decoder: $0)})
        return try! decoder.decode(T.self, from: data)
    }

    class func address(address: String? = nil,
                       balances: [Balance]? = nil)
        -> Address {
            let v: Address = self.stub(forResource: "address")
            return Address(
                address: address ?? v.address,
                balances: [self.balance()]
            )
    }

    class func balance(mintedToken: MintedToken? = nil,
                       amount: Double? = nil)
        -> Balance {
            let v: Balance = self.stub(forResource: "balance")
            return Balance(
                mintedToken: mintedToken ?? v.mintedToken,
                amount: amount ?? v.amount)
    }

    class func metadata(
        metadata: [String: Any]? = nil,
        metadataArray: [Any]? = nil)
        -> MetadataDummy {
            let v: MetadataDummy = self.stub(forResource: "metadata")
            return MetadataDummy(metadata: metadata ?? v.metadata!,
                                 metadataArray: metadataArray ?? v.metadataArray!,
                                 optionalMetadata: nil,
                                 optionalMetadataArray: nil,
                                 unavailableMetadata: nil,
                                 unavailableMetadataArray: nil)
    }

    class func mintedToken(id: String? = nil,
                           symbol: String? = nil,
                           name: String? = nil,
                           subUnitToUnit: Double? = nil)
        -> MintedToken {
            let v: MintedToken = self.stub(forResource: "minted_token")
            return MintedToken(id: id ?? v.id,
                               symbol: symbol ?? v.symbol,
                               name: name ?? v.name,
                               subUnitToUnit: subUnitToUnit ?? v.subUnitToUnit)
    }

    class func settings(mintedTokens: [MintedToken]? = nil)
        -> Setting {
            let v: Setting = self.stub(forResource: "setting")
            return Setting(mintedTokens: mintedTokens ?? v.mintedTokens)
    }

    class func transactionConsumption(
        id: String? = nil,
        status: TransactionConsumptionStatus? = nil,
        amount: Double? = nil,
        mintedToken: MintedToken? = nil,
        correlationId: String? = nil,
        idempotencyToken: String? = nil,
        transaction: Transaction? = nil,
        user: User? = nil,
        account: Account? = nil,
        transactionRequest: TransactionRequest? = nil,
        address: String? = nil,
        socketTopic: String? = nil,
        expirationDate: Date? = nil,
        approvedAt: Date? = nil,
        rejectedAt: Date? = nil,
        confirmedAt: Date? = nil,
        failedAt: Date? = nil,
        expiredAt: Date? = nil,
        createdAt: Date? = nil,
        metadata: [String: Any]? = nil)
        -> TransactionConsumption {
            let v: TransactionConsumption = self.stub(forResource: "transaction_consumption")
            return TransactionConsumption(id: id ?? v.id,
                                          status: status ?? v.status,
                                          amount: amount ?? v.amount,
                                          mintedToken: mintedToken ?? v.mintedToken,
                                          correlationId: correlationId ?? v.correlationId,
                                          idempotencyToken: idempotencyToken ?? v.idempotencyToken,
                                          transaction: transaction ?? v.transaction,
                                          address: address ?? v.address,
                                          user: user ?? v.user,
                                          account: account ?? v.account,
                                          transactionRequest: transactionRequest ?? v.transactionRequest,
                                          socketTopic: socketTopic ?? v.socketTopic,
                                          expirationDate: expirationDate ?? v.expirationDate,
                                          approvedAt: approvedAt ?? v.approvedAt,
                                          rejectedAt: rejectedAt ?? v.rejectedAt,
                                          confirmedAt: confirmedAt ?? v.confirmedAt,
                                          failedAt: failedAt ?? v.failedAt,
                                          expiredAt: expiredAt ?? v.expiredAt,
                                          createdAt: createdAt ?? v.createdAt,
                                          metadata: metadata ?? v.metadata)
    }

    class func transactionRequest(
        id: String? = nil,
        type: TransactionRequestType? = nil,
        mintedToken: MintedToken? = nil,
        amount: Double? = nil,
        address: String? = nil,
        user: User? = nil,
        account: Account? = nil,
        correlationId: String? = nil,
        status: TransactionRequestStatus? = nil,
        socketTopic: String? = nil,
        requireConfirmation: Bool? = nil,
        maxConsumptions: Int? = nil,
        consumptionLifetime: Int? = nil,
        expirationDate: Date? = nil,
        expirationReason: String? = nil,
        expiredAt: Date? = nil,
        allowAmountOverride: Bool? = nil,
        metadata: [String: Any]? = nil)
        -> TransactionRequest {
            let v: TransactionRequest = self.stub(forResource: "transaction_request")
            return TransactionRequest(
                id: id ?? v.id,
                type: type ?? v.type,
                mintedToken: mintedToken ?? v.mintedToken,
                amount: amount ?? v.amount,
                address: address ?? v.address,
                user: user ?? v.user,
                account: account ?? v.account,
                correlationId: correlationId ?? v.correlationId,
                status: status ?? v.status,
                socketTopic: socketTopic ?? v.socketTopic,
                requireConfirmation: requireConfirmation ?? v.requireConfirmation,
                maxConsumptions: maxConsumptions ?? v.maxConsumptions,
                consumptionLifetime: consumptionLifetime ?? v.consumptionLifetime,
                expirationDate: expirationDate ?? v.expirationDate,
                expirationReason: expirationReason ?? v.expirationReason,
                expiredAt: expiredAt ?? v.expiredAt,
                allowAmountOverride: allowAmountOverride ?? v.allowAmountOverride,
                metadata: metadata ?? v.metadata
            )
    }

    class func transaction(
        id: String? = nil,
        status: TransactionConsumptionStatus? = nil,
        from: TransactionSource? = nil,
        to: TransactionSource? = nil,
        exchange: TransactionExchange? = nil,
        metadata: [String: Any]? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil)
        -> Transaction {
            let v: Transaction = self.stub(forResource: "transaction")
            return Transaction(
                id: id ?? v.id,
                status: status ?? v.status,
                from: from ?? v.from,
                to: to ?? v.to,
                exchange: exchange ?? v.exchange,
                metadata: metadata ?? v.metadata,
                createdAt: createdAt ?? v.createdAt,
                updatedAt: updatedAt ?? v.updatedAt)
    }

    class func transactionSource(
        address: String? = nil,
        amount: Double? = nil,
        mintedToken: MintedToken? = nil)
        -> TransactionSource {
            let v: TransactionSource = self.stub(forResource: "transaction_source")
            return TransactionSource(address: address ?? v.address,
                                     amount: amount ?? v.amount,
                                     mintedToken: mintedToken ?? v.mintedToken)
    }

    class func transactionExchange(
        rate: Double? = nil)
        -> TransactionExchange {
            let v: TransactionExchange = self.stub(forResource: "transaction_exchange")
            return TransactionExchange(rate: rate ?? v.rate)
    }

    class func pagination(
        perPage: Int? = nil,
        currentPage: Int? = nil,
        isFirstPage: Bool? = nil,
        isLastPage: Bool? = nil)
        -> Pagination {
            let v: Pagination = self.stub(forResource: "pagination")
            return Pagination(perPage: perPage ?? v.perPage,
                              currentPage: currentPage ?? v.currentPage,
                              isFirstPage: isFirstPage ?? v.isFirstPage,
                              isLastPage: isLastPage ?? v.isLastPage)
    }

    class func transactionRequestCreateParams(
        type: TransactionRequestType = .receive,
        mintedTokenId: String = "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95",
        amount: Double? = 1337,
        address: String? = "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
        correlationId: String? = "31009545-db10-4287-82f4-afb46d9741d8",
        requireConfirmation: Bool = true,
        maxConsumptions: Int? = 1,
        consumptionLifetime: Int? = 1000,
        expirationDate: Date? = Date(timeIntervalSince1970: 0),
        allowAmountOverride: Bool = true,
        metadata: [String: Any] = [:])
        -> TransactionRequestCreateParams {
            return TransactionRequestCreateParams(
                type: type,
                mintedTokenId: mintedTokenId,
                amount: amount,
                address: address,
                correlationId: correlationId,
                requireConfirmation: requireConfirmation,
                maxConsumptions: maxConsumptions,
                consumptionLifetime: consumptionLifetime,
                expirationDate: expirationDate,
                allowAmountOverride: allowAmountOverride,
                metadata: metadata
                )!
    }

    class func transactionRequestGetParams(
        id: String? = "0a8a4a98-794b-419e-b92d-514e83657e75")
        -> TransactionRequestGetParams {
            return TransactionRequestGetParams(id: id!)
    }

    class func transactionConsumptionParams(
        transactionRequest: TransactionRequest = StubGenerator.stub(forResource: "transaction_request"),
        address: String? = "3b7f1c68-e3bd-4f8f-9916-4af19be95d00",
        mintedTokenId: String? = "BTC:861020af-17b6-49ee-a0cb-661a4d2d1f95",
        amount: Double? = 1337,
        idempotencyToken: String = "7a0ad55f-2084-4457-b871-1413142cde84",
        correlationId: String? = "45a5bce3-4e9d-4244-b3a9-64b7a4c5bdc4",
        expirationDate: Date? = Date(timeIntervalSince1970: 0),
        metadata: [String: Any] = [:]) -> TransactionConsumptionParams {
        return TransactionConsumptionParams(
            transactionRequest: transactionRequest,
            address: address,
            mintedTokenId: mintedTokenId,
            amount: amount,
            idempotencyToken: idempotencyToken,
            correlationId: correlationId,
            metadata: metadata
            )!
    }

    class func user(
        id: String? = nil,
        providerUserId: String? = nil,
        username: String? = nil,
        metadata: [String: Any]? = nil,
        socketTopic: String? = nil,
        encryptedMetadata: [String: Any]? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil)
        -> User {
            let v: User = self.stub(forResource: "user")
            return User(
                id: id ?? v.id,
                providerUserId: providerUserId ?? v.providerUserId,
                username: username ?? v.username,
                metadata: metadata ?? v.metadata,
                encryptedMetadata: encryptedMetadata ?? v.encryptedMetadata,
                socketTopic: socketTopic ?? v.socketTopic,
                createdAt: createdAt ?? v.createdAt,
                updatedAt: updatedAt ?? v.updatedAt
            )
    }

    class func paginationParams<T: Paginable>(
        page: Int? = 1,
        perPage: Int? = 20,
        searchTerm: String? = nil,
        searchTerms: [T.SearchableFields: String]? = nil,
        sortBy: T.SortableFields,
        sortDirection: SortDirection? = .ascending)
        -> PaginationParams<T> {
            return PaginationParams(page: page!,
                                    perPage: perPage!,
                                    searchTerm: searchTerm,
                                    searchTerms: searchTerms,
                                    sortBy: sortBy,
                                    sortDirection: sortDirection!)
    }

    class func transactionListParams(
        paginationParams: PaginationParams<Transaction>? = StubGenerator.paginationParams(sortBy: .id),
        address: String? = nil)
        -> TransactionListParams {
            return TransactionListParams(paginationParams: paginationParams!,
                                         address: address)
    }

    class func socketPayloadReceive(
        topic: String? = nil,
        event: SocketEvent? = nil,
        ref: String? = nil,
        data: GenericObject? = nil,
        version: String? = nil,
        error: APIError? = nil,
        success: Bool? = nil) -> SocketPayloadReceive {
        let v: SocketPayloadReceive = self.stub(forResource: "socket_response")
        return SocketPayloadReceive(topic: topic ?? v.topic,
                                    event: event ?? v.event,
                                    ref: ref ?? v.ref,
                                    data: data ?? v.data,
                                    version: version ?? v.version,
                                    success: success ?? v.success,
                                    error: error ?? v.error)
    }

}
