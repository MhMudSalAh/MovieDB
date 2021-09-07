//
//  MovieDetailsController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

class MovieDetailsController: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    var presenter: MovieDetailsPresenterInterface!
    var page: Paginate = Paginate()
    
    var movie: Movie = Movie() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        scaleButton()
        initTableView()
        presenter.getMovie(movie.id)
    }
    
    func scaleButton() {
        if LOCAL.getLanguage() == Language.EN.rawValue {
            btnBack.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        presenter.didClickToBack()
    }
}

extension MovieDetailsController: MovieDetailsView {
    
    func showLoading() {
        DispatchQueue.main.async {
            self.view.showAnimatedGradientSkeleton()
        }
    }
    
    func hideLoading() {
        endRefresherTable()
        tableView.reloadData()
        view.hideSkeleton()
    }
            
    func presentNetworkErrorScreen() {
        showNetworkErrorScreen(self, self.view)
    }
    
    func hideNetworkErrorScreen() {
        closeNetworkErrorScreen()
    }
}

extension MovieDetailsController: NetworkScreenControllerDelegate {
    func didClickTypeAgain() {
        hideNetworkErrorScreen()
        presenter.getMovie(movie.id)
    }
}
