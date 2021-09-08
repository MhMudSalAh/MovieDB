//
//  SearchController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

class SearchController: BaseController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: SearchPresenterInterface!
    
    var page: Paginate = Paginate()
    var footer: FooterCollection?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.backgroundColor = .primary
        searchController.searchBar.delegate = self
        searchController.searchBar.setImage(UIImage(named: "searchBar"), for: .search, state: .normal)
        setupSearchTextField(searchController)
        return searchController
    }()
    
    var movies: [Movie] = [] {
        didSet {
            reloadCollection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchController.hidesNavigationBarDuringPresentation = true
    }
    
    func setupView() {
        setupNavigation()
        setupSearhController()
        presentEmptyScreen()
        initCollectionView()
    }
    
    func setupNavigation() {
        navigationItem.title = localizedText("search")
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func reloadCollection() {
        DispatchQueue.main.async { [self] in
            hideSeacrhScreen()
            if movies.isEmpty {
                presentEmptyScreen()
            }
            collectionView.reloadData()
        }
    }
}

extension SearchController: SearchView {
    
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
        showNetworkErrorScreen(self, view)
    }
    
    func hideNetworkErrorScreen() {
        closeNetworkErrorScreen()
    }
    
    func presentEmptyScreen() {
        showEmptyScreen((searchController.searchBar.text?.isEmpty ?? false) ? .search : .searchEmpty, self, view)
    }
    
    func hideSeacrhScreen() {
        closeEmptyScreen()
    }
}

extension SearchController: NetworkScreenControllerDelegate, EmptyScreenControllerDelegate {
    
    func didClickTypeAgain() {
        presenter.doSearch(1, searchController.searchBar.text ?? "")
    }
}
