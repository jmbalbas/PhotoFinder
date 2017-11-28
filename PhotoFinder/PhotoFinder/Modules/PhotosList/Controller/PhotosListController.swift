//
//  PhotosListController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/28/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

protocol PhotosListPresenter: class {
    func viewIsReady()
    func cellSelected()
}

protocol PhotosListView: class {
    func displayImages(imageUrls: [String])
}

class PhotosListController {
    
    weak var view: PhotosListViewController?
    
}

extension PhotosListController: PhotosListPresenter {
    
    func viewIsReady() {
        // TODO
        // Get viewModel from API
        // Pass viewModel to the view
    }
    
    func cellSelected() {
        // TODO
    }
    
}
