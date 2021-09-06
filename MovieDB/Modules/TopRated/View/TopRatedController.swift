//
//  TopRatedController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import SkeletonView

class TopRatedController: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TopRatedPresenterInterface!
    var page: Paginate = Paginate()
    
    var topRated: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupNavigationTitle()
        initTableView()
        presenter.getTopRated(1)
    }
    
    func setupNavigationTitle() {
        navigationItem.title = localizedText("top-rated")
    }
}

extension TopRatedController: TopRatedView {
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func hideLoading() {
        endRefresherTable()
        view.hideSkeleton()
    }
        
    func endIndicator() {
        hideActivityIndicator()
        tableView.tableFooterView = nil
        tableView.tableFooterView?.isHidden = true
    }
    
    func presentNetworkErrorScreen() {
        showNetworkErrorScreen(self, self.view)
    }
    
    func hideNetworkErrorScreen() {
        closeNetworkErrorScreen()
    }
}

extension TopRatedController: NetworkScreenControllerDelegate {
    func didClickTypeAgain() {
        hideNetworkErrorScreen()
        presenter.getTopRated(1)
    }
}
