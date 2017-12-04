//
//  PhotoViewModel.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/29/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import Foundation

struct PhotoViewModel {
    var photoId: String
    var photoUrl: String
    var title: String
    var description: String
    var author: String
    var timesViewed: Int
    var likes: Int
}

struct PhotoMapper {
    
    static func map(_ responseModel: PhotoResponseModel) -> PhotoViewModel {
        let photoId = String(describing: responseModel.photoId ?? 0)
        let photoUrl = responseModel.photoUrl?.first ?? ""
        let title = responseModel.title ?? ""
        let description = responseModel.description ?? ""
        let author = "\(responseModel.author?.firstName ?? "") \(responseModel.author?.lastName ?? "")"
        let timesViewed = responseModel.timesViewed ?? 0
        let likes = responseModel.likes ?? 0
        
        return PhotoViewModel(photoId: photoId, photoUrl: photoUrl, title: title, description: description, author: author, timesViewed: timesViewed, likes: likes)
    }
    
}
