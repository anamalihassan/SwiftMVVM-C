//
//  AHClientHTTPNetworking.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation

// MARK: - Response Error Handling

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return Constants.APIMessages.NetworkError
        case .decoding:
            return Constants.APIMessages.DataDecodingError
        }
    }
}

// MARK: - Response Status codes

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}

// MARK: - Hande Response

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

// MARK: - Networ call Protocol

protocol AHDataProvider {
    func fetchRemote<Model: Decodable>(_ val: Model.Type, urlRequest: URLRequest, completion: @escaping (Result<Decodable, DataResponseError>) -> Void)
}

// MARK: - Network Calls

final class AHClientHTTPNetworking : AHDataProvider {
   
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchRemote<Model: Decodable>(_ val: Model.Type, urlRequest: URLRequest,
                         completion: @escaping (Result<Decodable, DataResponseError>) -> Void) {
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(Model.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
//            Utils.printLog(data)
            completion(Result.success(decodedResponse))
        }).resume()
    }
}
