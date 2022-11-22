//
//  NetworkError.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import Foundation

internal enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case invalidData
}

extension NetworkError: LocalizedError {
    internal var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Oops! The URL received is not correct! Please try again later."
        case .invalidRequest:
            return "Unable to complete your request. Please check your internet connection"
        case .invalidResponse:
            return "Invalid response from the server. Please try again."
        case .invalidData:
            return "The data received from the server was invalid. Please try again"
        }
    }
}
