//
//  RequestFactory.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 11/04/2021.
//

import Foundation

// MARK: - Request Types

final class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
