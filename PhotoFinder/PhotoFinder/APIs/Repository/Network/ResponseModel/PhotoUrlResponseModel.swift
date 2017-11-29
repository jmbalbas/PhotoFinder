//
//  PhotoUrlResponseModel.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct PhotoUrlResponseModel {
    var photoUrl: String?
}

extension PhotoUrlResponseModel: Decodable {
    
    private enum Keys: String, CodingKey {
        case photoUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        let photoUrl = try? container.decode(String.self, forKey: Keys.photoUrl)
        
        self.init(photoUrl: photoUrl)
    }
    
}
