//
//  RepositoryMock.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

/// Repository mock, retrieves data from JSON files.
class RepositoryMock {
    
    private enum JSONFilename: String {
        case getPhotosByKeyword = "GetPhotosByKeyword"
        case getPopularPhotos = "GetPopularPhotos"
    }

    // MARK: - Private methods
    
    private func loadJSON<T>(fileName: String, responseModel: T.Type, completionHandler: ((T?, ServiceError?) -> ())? ) where T: Decodable {

        // Load JSON from the bundle file
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
            let _ = jsonResult as? [String : Any]  else {
                if let completionHandler = completionHandler {
                    completionHandler(nil, ServiceError.failedLoadingJson)
                }
                return
        }
        
        DispatchQueue.main.async {
            guard let response = try? JSONDecoder().decode(responseModel, from: data) else {
                if let completionHandler = completionHandler {
                    completionHandler(nil, ServiceError.failedParsingJson)
                }
                return
            }
            
            if let completionHandler = completionHandler {
                completionHandler(response, nil)
            }
        }
    }
    
}

extension RepositoryMock: RepositoryProtocol {
    
    func getPhotosByKeyword(_ keyword: String, completionHandler: @escaping (PhotosContainerResponseModel?, Error?) -> ()) {
        loadJSON(fileName: JSONFilename.getPhotosByKeyword.rawValue, responseModel: PhotosContainerResponseModel.self, completionHandler: completionHandler)
    }
    
    func getPopularPhotos(completionHandler: @escaping (PhotosContainerResponseModel?, Error?) -> ()) {
        loadJSON(fileName: JSONFilename.getPopularPhotos.rawValue, responseModel: PhotosContainerResponseModel.self, completionHandler: completionHandler)
    }
    
}
