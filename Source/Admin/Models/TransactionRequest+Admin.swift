//
//  TransactionRequest+Admin.swift
//  Tests
//
//  Created by Mederic Petit on 8/10/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

extension TransactionRequest {
    @discardableResult
    /// Generate a transaction request from the given TransactionRequestParams object
    ///
    /// - Parameters:
    ///   - client: An API client.
    ///             This client need to be initialized with a AdminConfiguration struct before being used.
    ///   - params: The TransactionRequestCreateParams object describing the transaction request to be made.
    ///   - callback: The closure called when the request is completed
    /// - Returns: An optional cancellable request.
    public static func create(using client: HTTPAdminAPI,
                              params: TransactionRequestCreateParams,
                              callback: @escaping TransactionRequest.RetrieveRequestCallback)
        -> TransactionRequest.RetrieveRequest? {
        return self.retrieve(using: client,
                             endpoint: APIAdminEndpoint.transactionRequestCreate(params: params),
                             callback: callback)
    }
}
