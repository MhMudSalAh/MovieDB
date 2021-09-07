//
//  FavoritesRouter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

class FavoritesRouter: FavoritesRouterInterface {
    
    weak var viewController: UIViewController?
    
    func presentMovieDetails(_ movieId: Int) {
        let vc = MovieDetailsRouter.assembleModule(movieId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func assembleModule() -> UIViewController {
        let view: FavoritesController = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "FavoritesController") as! FavoritesController
            
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
            
        let navigation = NavController(rootViewController: view)
        navigation.setup()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        return navigation
    }
}
