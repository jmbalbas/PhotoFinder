//
//  PhotosListViewController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/28/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

class PhotosListViewController: UIViewController {

    private struct Constants {
        static let cellId = "imageCellId"
        static let cellsPerRow = 2
        static let collectionViewTopInset: CGFloat = 5
        static let collectionViewBottomInset: CGFloat = 5
        static let collectionViewLeftInset: CGFloat = 0
        static let collectionViewRightInset: CGFloat = 0
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            setupCollectionViewStyles()
            
            registerCells()
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    lazy var controller: PhotosListController = {
        let controller = PhotosListController()
        controller.view = self
        return controller
    }()
    
    private let images = [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4"), #imageLiteral(resourceName: "Image5"), #imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image4"), #imageLiteral(resourceName: "Image5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.viewIsReady()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape!!")
        } else {
            print("Portrait!!")
        }
        
    }
    
    private func registerCells() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
    }
    
    private func setupCollectionViewStyles() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        collectionView.contentInset = UIEdgeInsets(top: Constants.collectionViewTopInset,
                                                   left: Constants.collectionViewLeftInset,
                                                   bottom: Constants.collectionViewBottomInset,
                                                   right: Constants.collectionViewRightInset)
    }
    
}

extension PhotosListViewController: PhotosListView {
    
    func displayImages(imageUrls: [String]) {
        
    }
    
}

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsetsForNCells = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(Constants.cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.width - marginsAndInsetsForNCells) / CGFloat(Constants.cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

extension PhotosListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ImageCollectionViewCell
        cell.image = images[indexPath.row]
        return cell
    }
    
}

extension PhotosListViewController: UICollectionViewDelegate {
    
}
