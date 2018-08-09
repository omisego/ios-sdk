//
//  TestCredential.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 9/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

import OmiseGO

struct TestCredential: Credential {
    func authentication() throws -> String? {
        return "OMGClient \("123:123".data(using: .utf8)!.base64EncodedString())"
    }

    mutating func invalidate() {}
}
