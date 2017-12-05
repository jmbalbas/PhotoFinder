//
//  UserResponseModel.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct UserResponseModel {
    var userId: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
}

extension UserResponseModel: Decodable {
    
    private enum Keys: String, CodingKey {
        case userId = "id"
        case userName = "username"
        case firstName = "firstname"
        case lastName = "lastname"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        let userId = try? container.decode(String.self, forKey: Keys.userId)
        let userName = try? container.decode(String.self, forKey: Keys.userName)
        let firstName = try? container.decode(String.self, forKey: Keys.firstName)
        let lastName = try? container.decode(String.self, forKey: Keys.lastName)
        
        self.init(userId: userId, userName: userName, firstName: firstName, lastName: lastName)
    }
    
}
