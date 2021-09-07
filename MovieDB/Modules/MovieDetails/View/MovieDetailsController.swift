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
    @IBOutlet weak var viewFav: UIView!
    @IBOutlet weak var btnFav: UIButton!

    var presenter: MovieDetailsPresenterInterface!
    var page: Paginate = Paginate()
    
    var movie: Movie = Movie() {
        didSet {
            reloadTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        
    func setupFav() {
        if movie.favorite ?? true {
            btnFav.setImage(UIImage(named: "favoriteOn"), for: .normal)
            viewFav.backgroundColor = .white
        } else {
            viewFav.backgroundColor = .primary
            btnFav.setImage(UIImage(named: "favoriteOff"), for: .normal)
        }
    }
    
    func reverseFavoriteButton() {
        DispatchQueue.main.async { [self] in
            if !(movie.favorite ?? true) {
                viewFav.backgroundColor = .white
                btnFav.setImage(UIImage(named: "favoriteOn"), for: .normal)
                movie.favorite = true
            } else {
                viewFav.backgroundColor = .primary
                btnFav.setImage(UIImage(named: "favoriteOff"), for: .normal)
                movie.favorite = false
            }
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
        setupFav()
    }

    @IBAction func favouriteAction(_ sender: Any) {
        presenter.didClickFavorite(movie)
        reverseFavoriteButton()
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
