//
//  PhotosContainerResponseModel.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct PhotosContainerResponseModel {
    var currentPage: Int?
    var totalPages: Int?
    var totalItems: Int?
    var photos: [PhotoResponseModel]?
}

extension PhotosContainerResponseModel: Decodable {
    
    private enum Keys: String, CodingKey {
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
        case photos
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        let currentPage = try? container.decode(Int.self, forKey: Keys.currentPage)
        let totalPages = try? container.decode(Int.self, forKey: Keys.totalPages)
        let totalItems = try? container.decode(Int.self, forKey: Keys.totalItems)
        let photos = try? container.decode([PhotoResponseModel].self, forKey: Keys.photos)
        
        self.init(currentPage: currentPage, totalPages: totalPages, totalItems: totalItems, photos: photos)
    }
    
}
