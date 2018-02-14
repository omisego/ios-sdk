//
//  QRReader.swift
//  OmiseGO
//
//  Created by Mederic Petit on 8/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import UIKit
import AVFoundation

class QRReader: NSObject {

    let session = AVCaptureSession()
    var didReadCode: ((String) -> Void)!
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        return AVCaptureVideoPreviewLayer(session: self.session)
    }()
    private let sessionQueue: DispatchQueue = DispatchQueue(label: "io.omisego.qrqueue")

    init(onFindClosure: @escaping ((String) -> Void)) {
        self.didReadCode = onFindClosure
        super.init()
        self.sessionQueue.async {
            self.configureReader()
        }
    }

    private func configureReader() {
        let metadataOutput = AVCaptureMetadataOutput()
        for output in session.outputs { session.removeOutput(output) }
        for input in session.inputs { session.removeInput(input) }
        if let videoCaptireDevice = AVCaptureDevice.default(for: .video) {
            try? session.addInput(AVCaptureDeviceInput(device: videoCaptireDevice))
        }
        session.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        if metadataOutput.availableMetadataObjectTypes.contains(.qr) { metadataOutput.metadataObjectTypes = [.qr] }
        self.previewLayer.videoGravity = .resizeAspectFill
        session.commitConfiguration()
    }

    func startScanning() {
        self.sessionQueue.async {
            guard !self.session.isRunning else { return }
            self.session.startRunning()
        }
    }

    func stopScanning() {
        self.sessionQueue.async {
            guard self.session.isRunning else { return }
            self.session.stopRunning()
        }
    }

    class func isAvailable() -> Bool {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return false }
        return (try? AVCaptureDeviceInput(device: captureDevice)) != nil
    }

}

extension QRReader: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        self.sessionQueue.async { [weak self] in
            guard let weakSelf = self else { return }
            guard !metadataObjects.isEmpty,
                let metadataObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject,
                metadataObject.type == AVMetadataObject.ObjectType.qr,
                let decodedData = metadataObject.stringValue
                else { return }
            weakSelf.didReadCode(decodedData)
        }
    }
}
