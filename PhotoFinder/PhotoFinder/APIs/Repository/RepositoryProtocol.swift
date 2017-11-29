//
//  RepositoryProtocol.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    
    func getPhotosByKeyword(_ keyword: String, completionHandler: @escaping (PhotosContainerResponseModel?, Error?) -> ())
    
}
