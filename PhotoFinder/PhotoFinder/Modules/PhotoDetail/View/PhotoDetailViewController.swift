//
//  PhotoDetailViewController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/3/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    lazy var controller: PhotoDetailController = {
        let controller = PhotoDetailController()
        controller.view = self
        return controller
    }()
    
    private var viewModel: PhotoViewModel? {
        didSet {
            if let viewModel = viewModel {
                imageView.loadImageUrl(viewModel.photoUrl, placeholder: #imageLiteral(resourceName: "placeholder"))
                titleLabel.text = viewModel.title
                descriptionLabel.text = viewModel.description
                authorLabel.text = viewModel.author
                timesViewedLabel.text = String(describing: viewModel.timesViewed)
                likesLabel.text = String(describing: viewModel.likes)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timesViewedLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.viewIsReady()
    }

}

extension PhotoDetailViewController: PhotoDetailView {
    
    func displayViewModel(_ viewModel: PhotoViewModel) {
        self.viewModel = viewModel
    }
    
}
