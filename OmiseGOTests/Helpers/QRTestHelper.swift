//
//  QRTestHelper.swift
//  OmiseGOTests
//
//  Created by Mederic Petit on 7/2/2018 BE.
//  Copyright © 2018 OmiseGO. All rights reserved.
//

import UIKit

struct QRTestHelper {

    static func readQRCode(fromImage image: UIImage) -> String {
        let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode,
                                              context: nil,
                                              options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
        let features = detector.features(in: CIImage(image: image)!)
        var result: String = ""
        //swiftlint:disable:next force_cast
        for feature in features as! [CIQRCodeFeature] {
            result += feature.messageString ?? ""
        }
        return result
    }

}
