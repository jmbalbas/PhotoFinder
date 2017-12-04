//
//  Task.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/4/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

class Task {
    
    let path: String
    let method: Method
    
    /// Content-Type for HTTPHeaderField
    enum ContentType: String {
        case json = "application/json"
        case text = "text/plain"
    }
    
    /// httpMethod (GET, POST) of the request.
    /// POST includes httpBody & ContentType.
    enum Method {
        case GET
        case POST(Data?, ContentType?)
        
        var description: String {
            switch self {
            case .GET:
                return "GET"
            case .POST(_, _):
                return "POST"
            }
        }
    }
    
    /// List of endpoints.
    enum EndPoint {
        case getPhotosSearch
        case getPopularPhotos
        
        var description: String {
            switch self {
            case .getPhotosSearch:
                return "/photos/search"
            case .getPopularPhotos:
                return "/photos"
            }
        }
    }
    
    // MARK: - Init
    
    /// Initialize a task.
    ///
    /// - Parameters:
    ///   - method: The HTTP method.
    ///   - path: The endpoint.
    init(method: Method, path: EndPoint, params: [String:String] = [:]) {
        self.method = method
        
        if !params.isEmpty,
            let url = URL(string: path.description) {
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
            components?.path = url.absoluteString
            self.path = components!.url!.absoluteString
        } else {
            self.path = path.description
        }
    }
    
    /// Convert the class into a valid URLRequest.
    func asUrlRequest() -> URLRequest {
        let url = URL(string: Configuration.shared.environment.baseUrl() + path)!
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = method.description
        
        switch method {
        case .POST(let data, let contentType):
            request.httpBody = data
            if let contentType = contentType?.rawValue {
                request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            }
        default:
            break
        }
        
        return request
    }
    
}
