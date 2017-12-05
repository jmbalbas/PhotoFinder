//
//  PhotosListViewController.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 11/28/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

/// Delegate protocol for CollectionView.
protocol CollectionViewDelegate: class {
    func touchesBegan(_ collectionView: CollectionView)
}

/// Custom UICollectionView class for notifying the screen touches.
class CollectionView: UICollectionView {
    weak var touchDelegate: CollectionViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        touchDelegate?.touchesBegan(self)
    }
}

class PhotosListViewController: UIViewController {

    // MARK: - Constants
    
    private struct Constants {
        static let cellId = "imageCellId"
        static let detailSegueId = "showPhotoDetail"
        static let cellsPerRowInPortrait = 2
        static let cellsPerRowInLandscape = 4
        static let collectionViewTopInset: CGFloat = 5
        static let collectionViewBottomInset: CGFloat = 5
        static let collectionViewLeftInset: CGFloat = 0
        static let collectionViewRightInset: CGFloat = 0
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: CollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.touchDelegate = self
            collectionView.dataSource = self
            
            setupCollectionViewStyles()
            
            registerCells()
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.placeholder = "type_search_here".localized
            searchTextField.font = Components.Font.SemiBoldSmall
            searchTextField.textAlignment = .center
        }
    }
    
    // MARK: - Properties
    
    lazy var controller: PhotosListController = {
        let controller = PhotosListController()
        controller.view = self
        return controller
    }()
    
    private var viewModel: PhotosContainerViewModel? {
        didSet {
            if let viewModel = viewModel {
                noResultsLabel.isHidden = !viewModel.photos.isEmpty
                collectionView.reloadData()
            }
        }
    }
    
    private var cellsPerRow: Int {
        return (UIDevice.current.orientation.isLandscape) ? Constants.cellsPerRowInLandscape : Constants.cellsPerRowInPortrait
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    private lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Components.Font.SemiBoldMedium
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.text = "no_results".localized
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "photo_finder".localized
        
        controller.viewIsReady()
    }
    
    // MARK: - Override methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Refresh the collection view flow layout
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailSegueId {
            let photoDetailVC = segue.destination as! PhotoDetailViewController
            let indexPath = sender as! IndexPath
            
            photoDetailVC.controller.viewModel = viewModel?.photos[indexPath.row]
        }
    }
    
    // MARK: - Private methods
    
    /// Registers the collection view's cells.
    private func registerCells() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
    }
    
    /// Sets up the collection view styles.
    private func setupCollectionViewStyles() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.contentInset = UIEdgeInsets(top: Constants.collectionViewTopInset,
                                                   left: Constants.collectionViewLeftInset,
                                                   bottom: Constants.collectionViewBottomInset,
                                                   right: Constants.collectionViewRightInset)
        layout.invalidateLayout()
    }
    
    
    /// Dismisses the keyboard.
    /// It does it by resignFirstResponder instead of endEditing for performance reasons.
    private func dismissKeyboard() {
        guard let searchTextField = searchTextField else { return }
        
        searchTextField.resignFirstResponder()
    }
    
}

// MARK: - PhotosListView

extension PhotosListViewController: PhotosListView {
    
    func displayViewModel(_ viewModel: PhotosContainerViewModel) {
        self.viewModel = viewModel
    }
    
    func displayLoading() {
        activityIndicator.startAnimating()
    }
    
    func dismissLoading() {
        activityIndicator.stopAnimating()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsetsForNCells = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.width - marginsAndInsetsForNCells) / CGFloat(cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

// MARK: - UICollectionViewDataSource

extension PhotosListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! ImageCollectionViewCell
        cell.imageUrl = viewModel?.photos[indexPath.row].photoUrl
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension PhotosListViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.detailSegueId, sender: indexPath)
    }
    
}

// MARK: - CollectionViewDelegate

extension PhotosListViewController: CollectionViewDelegate {
    
    func touchesBegan(_ collectionView: CollectionView) {
        dismissKeyboard()
    }
    
}

// MARK: - UITextFieldDelegate

extension PhotosListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        controller.userIsSearchingFor(textField.text ?? "")

        dismissKeyboard()
        noResultsLabel.isHidden = true

        return true
    }
    
}
