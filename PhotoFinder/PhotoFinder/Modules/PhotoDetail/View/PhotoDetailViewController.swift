//
//  PhotoDetailViewController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/3/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    // MARK: - Properties
    
    lazy var controller: PhotoDetailController = {
        let controller = PhotoDetailController()
        controller.view = self
        return controller
    }()
    
    private var viewModel: PhotoViewModel? {
        didSet {
            if let viewModel = viewModel {
                imageView.loadImageUrl(viewModel.photoUrl, placeholder: Components.Image.Placeholder)
                titleLabel.text = viewModel.title
                descriptionLabel.text = viewModel.description
                authorLabel.text = viewModel.author
                timesViewedLabel.text = String(describing: viewModel.timesViewed)
                likesLabel.text = String(describing: viewModel.likes)
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Components.Font.BoldLarge
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = Components.Font.RegularSmall
        }
    }
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            authorLabel.font = Components.Font.RegularSmall
        }
    }
    @IBOutlet weak var timesViewedLabel: UILabel! {
        didSet {
            timesViewedLabel.font = Components.Font.RegularSmall
        }
    }
    @IBOutlet weak var likesLabel: UILabel! {
        didSet {
            likesLabel.font = Components.Font.RegularSmall
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.viewIsReady()
    }

}

// MARK: - PhotoDetailView

extension PhotoDetailViewController: PhotoDetailView {
    
    func displayViewModel(_ viewModel: PhotoViewModel) {
        self.viewModel = viewModel
    }
    
}
