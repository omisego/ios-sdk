//
//  Configuration.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

public protocol Configuration {
    /// The current SDK version
    var apiVersion: String { get }
    /// The base URL of the wallet server:
    /// When initializing the HTTPClient, this needs to be an http(s) url
    /// When initializing the SocketClient, this needs to be a ws(s) url
    var baseURL: String { get }
    var credentials: Credential { get set }
    var debugLog: Bool { get }
}
