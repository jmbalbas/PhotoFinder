//
//  Session.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/4/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

/// Communication class responsible for launch requests to the server.
class Session {
    
    // MARK: - Properties
    
    private var configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.allowsCellularAccess = true
        
        return configuration
    }()
    
    private lazy var session: URLSession = {
       return URLSession(configuration: configuration)
    }()
    
    // MARK: - Public methods
    
    func dataTask(_ task: Task, completionHandler: @escaping (Result<Data, ServiceError>) -> ()) {
        let urlRequest = task.asUrlRequest()
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                let errorCode = (error as NSError).code
                switch errorCode {
                case NSURLErrorNotConnectedToInternet:
                    completionHandler(Result.failure(ServiceError.noInternetConnection))
                default:
                    completionHandler(Result.failure(ServiceError.custom(error.localizedDescription)))
                }
            } else if let data = data {
                completionHandler(Result.success(data))
            } else {
                completionHandler(Result.failure(ServiceError.other))
            }
        }.resume()
    }
    
}
