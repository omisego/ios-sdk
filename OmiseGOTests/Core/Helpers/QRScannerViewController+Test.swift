//
//  QRScannerViewController+Test.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 9/8/18.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

@testable import OmiseGO

extension QRScannerViewController {
    convenience init?(delegate: QRScannerViewControllerDelegate, verifier: MockQRVerifier, cancelButtonTitle: String) {
        self.init(delegate: delegate,
                  verifier: verifier,
                  cancelButtonTitle: cancelButtonTitle,
                  viewModel: QRScannerViewModel(verifier: verifier))
    }
}
