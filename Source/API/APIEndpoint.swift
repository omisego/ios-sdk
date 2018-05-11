//
//  APIEndpoint.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// Represents an api endpoint.
enum APIEndpoint {

    case getCurrentUser
    case getAddresses
    case getSettings
    case getTransactions(params: TransactionListParams)
    case transactionRequestCreate(params: TransactionRequestCreateParams)
    case transactionRequestGet(params: TransactionRequestGetParams)
    case transactionRequestConsume(params: TransactionConsumptionParams)
    case transactionConsumptionApprove(params: TransactionConsumptionConfirmationParams)
    case transactionConsumptionReject(params: TransactionConsumptionConfirmationParams)
    case logout
    case custom(path: String, task: HTTPTask)

    var path: String {
        switch self {
        case .getCurrentUser:
            return "/me.get"
        case .getAddresses:
            return "/me.list_balances"
        case .getSettings:
            return "/me.get_settings"
        case .getTransactions:
            return "/me.list_transactions"
        case .transactionRequestCreate:
            return "/me.create_transaction_request"
        case .transactionRequestGet:
            return "/me.get_transaction_request"
        case .transactionRequestConsume:
            return "/me.consume_transaction_request"
        case .transactionConsumptionApprove:
            return "/me.approve_transaction_consumption"
        case .transactionConsumptionReject:
            return "/me.reject_transaction_consumption"
        case .logout:
            return "/logout"
        case .custom(let path, _):
            return path
        }
    }

    var task: HTTPTask {
        switch self {
        case .getCurrentUser, .getAddresses, .getSettings, .logout: // Send no parameters
            return .requestPlain
        case .transactionRequestCreate(let parameters):
            return .requestParameters(parameters: parameters)
        case .transactionRequestGet(let parameters):
            return .requestParameters(parameters: parameters)
        case .transactionRequestConsume(let parameters):
            return .requestParameters(parameters: parameters)
        case .getTransactions(let parameters):
            return .requestParameters(parameters: parameters)
        case .transactionConsumptionApprove(let parameters):
            return .requestParameters(parameters: parameters)
        case .transactionConsumptionReject(let parameters):
            return .requestParameters(parameters: parameters)
        case .custom(_, let task):
            return task
        }
    }

}
