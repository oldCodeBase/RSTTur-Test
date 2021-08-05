//
//  HTTPError.swift
//  RSTTur-Test
//
//  Created by Ibragim Akaev on 04/08/2021.
//

import Foundation
import Combine

enum HTTPError: Error, CustomStringConvertible {
    case nonHTTPResponse
    case requestFailed(Int)
    case serverError(Int)
    case networkError(Error)
    case decodingError(DecodingError)
    
    var isRetriable: Bool {
        switch self {
        case .decodingError:
            return false
            
        case .requestFailed(let status):
            let timeoutStatus = 408
            let rateLimitStatus = 429
            return [timeoutStatus, rateLimitStatus].contains(status)
            
        case .serverError, .networkError, .nonHTTPResponse:
            return true
        }
    }
    
    var description: String {
        switch self {
        case .nonHTTPResponse: return "Non-HTTP response received"
        case .requestFailed(let status): return "Received HTTP \(status)"
        case .serverError(let status): return "Server Error - \(status)"
        case .networkError(let error): return "Failed to load the request: \(error)"
        case .decodingError(let decError): return "Failed to process response: \(decError)"
        }
    }
}
