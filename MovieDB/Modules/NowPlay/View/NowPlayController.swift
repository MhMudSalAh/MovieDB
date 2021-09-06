//
//  NowPlayController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import SkeletonView

class NowPlayController: BaseController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: NowPlayPresenterInterface!
    var page: Paginate = Paginate()
    var footer: FooterCollection?
    
    var nowPlaying: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupNavigationTitle()
        initCollectionView()
        presenter.getNowPlaying(1)
    }
    
    func setupNavigationTitle() {
        navigationItem.title = localizedText("now-playing")
    }
}

extension NowPlayController: NowPlayView {
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func hideLoading() {
        endRefresherCollection()
        footer?.stopAnimate()
        view.hideSkeleton()
    }
        
    func presentNetworkErrorScreen() {
        showNetworkErrorScreen(self, self.view)
    }
    
    func hideNetworkErrorScreen() {
        closeNetworkErrorScreen()
    }
}

extension NowPlayController: NetworkScreenControllerDelegate {
    func didClickTypeAgain() {
        hideNetworkErrorScreen()
        
    }
}
