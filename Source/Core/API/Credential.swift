//
//  Credential.swift
//  OmiseGO
//
//  Created by Mederic Petit on 6/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

public protocol Credential {
    func authentication() throws -> String?
    mutating func invalidate()
}
