//
//  ServiceError.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnection
    case failedParsingJson
    case failedLoadingJson
    case custom(String)
    case other
}

extension ServiceError: LocalizedError {
    
    var description: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .failedParsingJson:
            return "Failed parsing JSON"
        case .failedLoadingJson:
            return "Failed loading JSON"
        case .other:
            return "Something went wrong"
        case .custom(let message):
            return message
        }
    }
    
}

