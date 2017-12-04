//
//  PhotosListController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/28/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

protocol PhotosListPresenter {
    func viewIsReady()
    func cellSelected(at indexPath: IndexPath)
}

protocol PhotosListView: NSObjectProtocol {
    func displayViewModel(_ viewModel: PhotosContainerViewModel)
}

class PhotosListController {
    
    private struct Constants {
        static let detailSegueId = "showPhotoDetail"
    }
    
    weak var view: PhotosListViewController?
    
    private var photosContainerViewModel: PhotosContainerViewModel? {
        didSet {
            if let photosContainer = photosContainerViewModel {
                view?.displayViewModel(photosContainer)
            }
        }
    }
    
    private func getViewModel() {
        let repository = RepositoryFactory.getRepository()

//        repository.getPopularPhotos {[weak self] (response, error) in
//            guard let weakSelf = self else { return }
//
//            DispatchQueue.main.async {
//                if let response = response {
//                    weakSelf.photosContainerViewModel = PhotosContainerMapper.map(response)
//                } else if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        repository.getPhotosByKeyword("moon") { [weak self] (response, error) in
            guard let weakSelf = self else { return }

            DispatchQueue.main.async {
                if let response = response {
                    weakSelf.photosContainerViewModel = PhotosContainerMapper.map(response)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

extension PhotosListController: PhotosListPresenter {
    
    func viewIsReady() {
        getViewModel()
    }
    
    func cellSelected(at indexPath: IndexPath) {
//        view?.performSegue(withIdentifier: Constants.detailSegueId, sender: indexPath)
    }
    
}
