//
//  OMGClient.swift
//  OmiseGO
//
//  Created by Mederic Petit on 9/10/2017.
//  Copyright © 2017-2018 Omise Go Pte. Ltd. All rights reserved.
//

/// Represents an OMGClient that should be initialized using an OMGConfiguration
public class OMGClient {

    let authScheme = "OMGClient"
    let operationQueue: OperationQueue = OperationQueue()

    var session: URLSession!
    var config: OMGConfiguration

    /// The websocket object managing the channels and connection.
    /// You can observe its connection events using a SocketConnectionDelegate
    /// This is a lazy initialized object that will use authentication provided in the OMGConfiguration object.
    /// If the authentication token provided appears to be invalid, you should initialize a new OMGClient.
    public lazy var websocket: Socket = {
        let request = try? RequestBuilder(requestParameters: RequestParameters(config: self.config)).buildWebsocketRequest()
        assert(request != nil, "Invalid websocket url")
        return Socket(request: request!)
    }()

    /// Initialize a client using a configuration object
    ///
    /// - Parameter config: The configuration object
    public init(config: OMGConfiguration) {
        self.config = config
        self.session = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                  delegate: nil,
                                  delegateQueue: self.operationQueue)
    }

    @discardableResult
    func request<ResultType>(toEndpoint endpoint: APIEndpoint,
                             callback: OMGRequest<ResultType>.Callback?) -> OMGRequest<ResultType>? {
        do {
            let request: OMGRequest<ResultType> = OMGRequest(client: self, endpoint: endpoint, callback: callback)
            return try request.start()
        } catch let error as OmiseGOError {
            performCallback {
                callback?(.fail(error: error))
            }
        } catch let error {
            // Can't actually throw another error
            performCallback {
                callback?(.fail(error: .other(error: error)))
            }
        }

        return nil
    }

    func performCallback(_ callback: @escaping () -> Void) {
        OperationQueue.main.addOperation(callback)
    }

}

extension OMGClient {

    /// Logout the current user (invalidate the provided authenticationToken).
    ///
    /// - callback: The closure called when the request is completed
    /// - Returns: An optional cancellable request.
    @discardableResult
    public func logout(withCallback callback: @escaping OMGRequest<EmptyResponse>.Callback)
        -> OMGRequest<EmptyResponse>? {
        let request: OMGRequest<EmptyResponse>? = self.request(toEndpoint: .logout) { (result) in
            switch result {
            case .success(data: let data):
                self.config.authenticationToken = nil
                callback(.success(data: data))
            case .fail(let error):
                callback(.fail(error: error))
            }
        }
        return request
    }

}
