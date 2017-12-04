//
//  APIKeys.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/4/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct APIKeys {
    
    static func valueForAPIKey(_ keyname:String) -> String? {
        // Get the file path for keys.plist
        let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist")
        
        // Put the keys in a dictionary
        let plist = NSDictionary(contentsOfFile: filePath!)
        
        // Pull the value for the key
        if let value = plist?.object(forKey: keyname),
            let valueString = value as? String {
            
            return valueString
        }
        
        return nil
    }
    
}
