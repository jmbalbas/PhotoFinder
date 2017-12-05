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
    func userIsSearchingFor(_ text: String)
}

protocol PhotosListView: NSObjectProtocol {
    func displayViewModel(_ viewModel: PhotosContainerViewModel)
    func displayLoading()
    func dismissLoading()
}

class PhotosListController {
    
    private struct Constants {
        static let detailSegueId = "showPhotoDetail"
    }
    
    weak var view: PhotosListViewController?
    
    private var repository: RepositoryProtocol {
        return RepositoryFactory.getRepository()
    }
    
    private var photosContainerViewModel: PhotosContainerViewModel? {
        didSet {
            if let photosContainer = photosContainerViewModel {
                view?.displayViewModel(photosContainer)
            }
        }
    }
    
    private func getPopularPhotos() {
        view?.displayLoading()
        repository.getPopularPhotos {[weak self] (response, error) in
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.dismissLoading()
                
                if let response = response {
                    weakSelf.photosContainerViewModel = PhotosContainerMapper.map(response)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getPhotosBy(keyword: String) {
        view?.displayLoading()
        repository.getPhotosByKeyword(keyword) { [weak self] (response, error) in
            guard let weakSelf = self else { return }

            DispatchQueue.main.async {
                self?.view?.dismissLoading()
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
        getPopularPhotos()
    }
    
    func userIsSearchingFor(_ text: String) {
        if text.isEmpty {
            getPopularPhotos()
        } else {
            getPhotosBy(keyword: text)
        }
    }
    
}
