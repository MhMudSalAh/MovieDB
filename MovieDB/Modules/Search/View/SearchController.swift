//
//  SearchController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

class SearchController: BaseController {
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
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
        initCollectionView()
        presentSeacrhScreen()
    }
    
    func setupNavigation() {
        navigationItem.title = localizedText("search")
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
    }
    
    func reloadCollection() {
        DispatchQueue.main.async { [self] in
            if movies.isEmpty && (searchController.searchBar.text?.isEmpty ?? true) {
                presentSeacrhScreen()
            } else if movies.isEmpty && !(searchController.searchBar.text?.isEmpty ?? true) {
                presentEmptyScreen()
            } else {
                if !movies.isEmpty {
                    hideSeacrhScreen()
                }
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
    
    func presentSeacrhScreen() {
        viewSearch.isHidden = false
        lblTitle.text = localizedText("search_title")
        lblDescription.isHidden = true
    }
    
    func hideSeacrhScreen() {
        viewSearch.isHidden = true
    }
    
    func presentEmptyScreen() {
        viewSearch.isHidden = false
        lblDescription.isHidden = false
        lblTitle.text = localizedText("empty_search_title")
        lblDescription.text = localizedText("empty_search_description")
    }
}

extension SearchController: NetworkScreenControllerDelegate, EmptyScreenControllerDelegate {
    
    func didClickTypeAgain() {
        presenter.doSearch(1, searchController.searchBar.text ?? "")
    }
}
