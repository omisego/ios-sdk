//
//  HTTPAPI+Test.swift
//  Tests
//
//  Created by Mederic Petit on 9/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

@testable import OmiseGO

extension HTTPAPI {
    convenience init(config: TestConfiguration) {
        self.init()
        self.config = config
    }
}
