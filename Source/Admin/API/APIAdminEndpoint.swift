//
//  APIAdminEndpoint.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// Represents an admin api endpoint.
enum APIAdminEndpoint: APIEndpoint {
    case login(params: LoginParams)

    var path: String {
        switch self {
        case .login:
            return "/admin.login"
        }
    }

    var task: HTTPTask {
        switch self {
        case let .login(parameters):
            return .requestParameters(parameters: parameters)
        }
    }
}
