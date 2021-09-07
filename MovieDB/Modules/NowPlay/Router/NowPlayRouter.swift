//
//  NowPlayRouter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class NowPlayRouter: NowPlayRouterInterface {
    
    weak var viewController: UIViewController?
    
    func presentMovieDetails(_ movieId: Int) {
        let vc = MovieDetailsRouter.assembleModule(movieId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func assembleModule() -> UIViewController {
        let view: NowPlayController = UIStoryboard(name: "NowPlay", bundle: nil).instantiateViewController(withIdentifier: "NowPlayController") as! NowPlayController
            
        let presenter = NowPlayPresenter()
        let interactor = NowPlayInteractor()
        let router = NowPlayRouter()
            
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
