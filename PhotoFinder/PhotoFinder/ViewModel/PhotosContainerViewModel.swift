//
//  PhotosContainerViewModel.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct PhotosContainerViewModel {
    let currentPage: Int
    let totalPages: Int
    let totalItems: Int
    let photos: [PhotoViewModel]
}

struct PhotosContainerMapper {
    
    static func map(_ responseModel: PhotosContainerResponseModel) -> PhotosContainerViewModel {
        let currentPage = responseModel.currentPage ?? 0
        let totalPages = responseModel.totalPages ?? 0
        let totalItems = responseModel.totalItems ?? 0

        var photos: [PhotoViewModel] = []
        responseModel.photos?.forEach {
            let photo = PhotoMapper.map($0)
            photos.append(photo)
        }
        
        return PhotosContainerViewModel(currentPage: currentPage, totalPages: totalPages, totalItems: totalItems, photos: photos)
    }
    
}
