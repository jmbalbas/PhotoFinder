//
//  PhotoResponseModel.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct PhotoResponseModel {
    var photoId: Int?
    var photoUrl: [String]?
    var title: String?
    var description: String?
    var author: UserResponseModel?
    var timesViewed: Int?
    var likes: Int?
}

extension PhotoResponseModel: Decodable {
    
    private enum Keys: String, CodingKey {
        case photoId = "id"
        case photoUrl = "image_url"
        case title = "name"
        case description
        case authorName = "user"
        case timesViewed = "times_viewed"
        case likes = "votes_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        let photoId = try? container.decode(Int.self, forKey: Keys.photoId)
        let photoUrl = try? container.decode([String].self, forKey: Keys.photoUrl)
        let title = try? container.decode(String.self, forKey: Keys.title)
        let description = try? container.decode(String.self, forKey: Keys.description)
        let author = try? container.decode(UserResponseModel.self, forKey: Keys.authorName)
        let timesViewed = try? container.decode(Int.self, forKey: Keys.timesViewed)
        let likes = try? container.decode(Int.self, forKey: Keys.likes)
        
        self.init(photoId: photoId, photoUrl: photoUrl, title: title, description: description, author: author, timesViewed: timesViewed, likes: likes)
    }
    
}
