//
//  Configuration.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct Configuration {
    
    static let shared = Configuration()
    
    enum Environment: String {
        case debug
        case release
        
        func baseUrl() -> String {
            return "https://api.500px.com/v1"
        }
    }
    
    var environment: Environment = {
       guard let object = Bundle.main.object(forInfoDictionaryKey: "Configuration"),
        let currentConfiguration = object as? String else { return .debug }
        
        switch currentConfiguration {
        case "Debug":
            return .debug
        case "Release":
            return .release
        default:
            return .debug
        }
    }()
    
}
