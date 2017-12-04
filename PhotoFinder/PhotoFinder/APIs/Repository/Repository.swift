//
//  Repository.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

class Repository: RepositoryProtocol {
    
    func getPhotosByKeyword(_ keyword: String, completionHandler: @escaping (PhotosContainerResponseModel?, Error?) -> ()) {
        let task = Task(method: .GET, path: .getPhotosSearch(keyword))
        let session = Session()
        
        session.dataTask(task) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder().decode(PhotosContainerResponseModel.self, from: data) else {
                    completionHandler(nil, ServiceError.failedParsingJson)
                    return
                }
                completionHandler(response, nil)
            case .failure(let error):
                completionHandler(nil, ServiceError.custom(error.localizedDescription))
            }
        }
    }
    
    func getPopularPhotos(completionHandler: @escaping (PhotosContainerResponseModel?, Error?) -> ()) {
        let task = Task(method: .GET, path: .getPopularPhotos)
        let session = Session()
        
        session.dataTask(task) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder().decode(PhotosContainerResponseModel.self, from: data) else {
                    completionHandler(nil, ServiceError.failedParsingJson)
                    return
                }
                completionHandler(response, nil)
            case .failure(let error):
                completionHandler(nil, ServiceError.custom(error.localizedDescription))
            }
        }
    }
    
}
