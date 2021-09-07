//
//  FavoritesController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit
import SkeletonView

class FavoritesController: BaseController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: FavoritesPresenterInterface!
    var page: Paginate = Paginate()
    
    var favorites: [Movie] = [] {
        didSet {

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupNavigationTitle()
        initCollectionView()
        getFavorites()
    }
    
    func setupNavigationTitle() {
        navigationItem.title = localizedText("favorites")
    }
    
    func getFavorites() {
        DispatchQueue.main.async { [self] in
            collectionView.reloadData()
            if FAVORITE.favorites.isEmpty {
                showEmptyScreen()
            } else {
                hideEmptyScreen()
            }
        }
    }
    
    @objc func receivedNotification(notification: Notification) {
        getFavorites()
    }
}

extension FavoritesController: FavoritesView {
        
    func showLoading() {
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func hideLoading() {
        endRefresherCollection()
        view.hideSkeleton()
    }
            
    func showEmptyScreen() {
        showEmptyScreen(.favourites, self, self.view)
    }
    
    func hideEmptyScreen() {
        closeEmptyScreen()
    }
    
    func presentNetworkErrorScreen() {
        showNetworkErrorScreen(self, self.view)
    }
    
    func hideNetworkErrorScreen() {
        closeNetworkErrorScreen()
    }
}

extension FavoritesController: NetworkScreenControllerDelegate, EmptyScreenControllerDelegate {
    func didClickTypeAgain() {
        hideNetworkErrorScreen()
        presenter.getFavorites()
    }
}

extension FavoritesController: FavoritesDelegate {
    func didClickDeleteFavorite(_ movieId: Int) {
        presenter.didClickToUnFavorite(movieId)
    }
}
