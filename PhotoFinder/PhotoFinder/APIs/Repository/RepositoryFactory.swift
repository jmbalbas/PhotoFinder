//
//  RepositoryFactory.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

/// Repository factory, for managing different types of repositories.
class RepositoryFactory {
    
    // MARK: - Public methods
    
    /// Returns a repository based on the current scheme.
    class func getRepository() -> RepositoryProtocol {
        let currentConfiguration = Configuration.shared.environment
        
        switch currentConfiguration {
        case .debug:
            return RepositoryMock()
        case .release:
            return Repository()
        }
    }
    
}
