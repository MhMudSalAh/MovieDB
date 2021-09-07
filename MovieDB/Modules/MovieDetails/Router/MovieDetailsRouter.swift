//
//  MovieDetailsRouter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

class MovieDetailsRouter: MovieDetailsRouterInterface {
    
    weak var viewController: UIViewController?
    
    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    static func assembleModule(_ movieId: Int) -> UIViewController {
        let view: MovieDetailsController = UIStoryboard(name: "MovieDetails", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsController") as! MovieDetailsController
            
        let presenter = MovieDetailsPresenter()
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        
        view.movie.id = movieId
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
