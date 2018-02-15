//
//  QRScannerViewController.swift
//  OmiseGO
//
//  Created by Mederic Petit on 8/2/2561 BE.
//  Copyright © 2561 OmiseGO. All rights reserved.
//

import UIKit

public protocol QRScannerViewControllerDelegate: class {
    func scannerDidCancel(scanner: QRScannerViewController)
    func scannerDidDecode(scanner: QRScannerViewController, transactionRequest: TransactionRequest)
    func scannerDidFailToDecode(scanner: QRScannerViewController, withError error: OmiseGOError)
}

public class QRScannerViewController: UIViewController {

    public weak var delegate: QRScannerViewControllerDelegate?
    var viewModel: QRScannerViewModelProtocol!
    lazy var loadingView: QRScannerLoadingView = {
        let loadingView = QRScannerLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isUserInteractionEnabled = false
        return loadingView
    }()

    init?(delegate: QRScannerViewControllerDelegate,
          client: OMGClient,
          cancelButtonTitle: String,
          viewModel: QRScannerViewModelProtocol) {
        guard viewModel.isQRCodeAvailable() else {
            omiseGOWarn("QR code reader is not available on this device")
            return nil
        }
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.configureViewModel()
        self.delegate = delegate
        self.setupUIWithCancelButtonTitle(cancelButtonTitle)
    }

    public convenience init?(delegate: QRScannerViewControllerDelegate, client: OMGClient, cancelButtonTitle: String) {
        self.init(delegate: delegate,
                  client: client,
                  cancelButtonTitle: cancelButtonTitle,
                  viewModel: QRScannerViewModel(client: client))
    }

    func configureViewModel() {
        self.viewModel.onLoadingStateChange = { (isLoading) in
            self.toggleLoadingOverlay(show: isLoading)
        }
        self.viewModel.onGetTransactionRequest = { (transactionRequest) in
            self.delegate?.scannerDidDecode(scanner: self, transactionRequest: transactionRequest)
        }
        self.viewModel.onError = { (error) in
            self.delegate?.scannerDidFailToDecode(scanner: self, withError: error)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        omiseGOWarn("init(coder:) shouldn't be called direcly, please use the designed init(delegate:client:) instead")
        return nil
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.startScanning()
    }

    override public func viewWillDisappear(_ animated: Bool) {
        self.viewModel.stopScanning()
        super.viewWillDisappear(animated)
    }

    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.viewModel.updateQRReaderPreviewLayer(withFrame: self.view.bounds)
    }

    func toggleLoadingOverlay(show: Bool) {
        show ? self.loadingView.showLoading() : self.loadingView.hideLoading()
    }

    private func setupUIWithCancelButtonTitle(_ cancelButtonTitle: String) {
        self.view.backgroundColor = .black
        let qrScannerView = QRScannerView(frame: self.view.frame,
                                          readerPreviewLayer: self.viewModel.readerPreviewLayer())
        qrScannerView.translatesAutoresizingMaskIntoConstraints = false
        qrScannerView.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        qrScannerView.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        self.view.addSubview(qrScannerView)
        self.view.addSubview(self.loadingView)
        [NSLayoutAttribute.left, .top, .right, .bottom].forEach({ (attribute) in
            self.view.addConstraint(NSLayoutConstraint(item: qrScannerView,
                                                       attribute: attribute,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: attribute,
                                                       multiplier: 1,
                                                       constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.loadingView,
                                                       attribute: attribute,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: attribute,
                                                       multiplier: 1,
                                                       constant: 0))
        })

    }

    @objc func didTapCancel(_ button: UIButton) {
        self.delegate?.scannerDidCancel(scanner: self)
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
