//
//  Erros.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 10/04/21.
//

import Foundation

enum AppConnectionStatus: Error {
    
    case success
    case notFound
    case timedOut
    case invalidRequest
    case invalidCredentials
    case invalidResponse
    case badURL
    case unknown
    
    static func status(for responseCode: Int ) -> AppConnectionStatus {
        
        switch responseCode {
        case 200:
            return .success
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        default:
            return .unknown
        }
    }
}

