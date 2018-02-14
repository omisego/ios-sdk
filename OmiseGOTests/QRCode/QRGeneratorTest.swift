//
//  QRGeneratorTest.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 6/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import XCTest
@testable import OmiseGO

class QRGeneratorTest: XCTestCase {

    func testImageSize() {
        let data = "Test data".data(using: .isoLatin1)!
        if let qrCode = QRCode.generateQRCode(fromData: data, outputSize: CGSize(width: 150, height: 150)) {
            XCTAssertEqual(qrCode.size.width, 150)
            XCTAssertEqual(qrCode.size.height, 150)
        } else {
            XCTFail("Failed to generate the qrCode")
        }
    }

    func testGeneratedQRCodeContainsInputText() {
        let inputText = "Test data"
        let data = inputText.data(using: .isoLatin1)!
        if let qrCode = QRCode.generateQRCode(fromData: data, outputSize: CGSize(width: 200, height: 200)) {
            let decodedText = QRTestHelper.readQRCode(fromImage: qrCode)
            XCTAssertEqual(decodedText, inputText)
        } else {
            XCTFail("Failed to generate the qrCode")
        }
    }

}
