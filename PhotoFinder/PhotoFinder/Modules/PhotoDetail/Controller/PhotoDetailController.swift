//
//  PhotoDetailController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/3/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

protocol PhotoDetailPresenter {
    func viewIsReady()
}

protocol PhotoDetailView: NSObjectProtocol {
    func displayViewModel(_ viewModel: PhotoViewModel)
}

class PhotoDetailController {
 
    weak var view: PhotoDetailViewController?
    var viewModel: PhotoViewModel?
    
}

extension PhotoDetailController: PhotoDetailPresenter {
    
    func viewIsReady() {
        if let viewModel = viewModel {
            view?.displayViewModel(viewModel)
        }
    }
    
}
