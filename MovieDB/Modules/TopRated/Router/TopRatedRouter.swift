//
//  TopRatedRouter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class TopRatedRouter: TopRatedRouterInterface {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view: TopRatedController = UIStoryboard(name: "TopRated", bundle: nil).instantiateViewController(withIdentifier: "TopRatedController") as! TopRatedController
            
        let presenter = TopRatedPresenter()
        let interactor = TopRatedInteractor()
        let router = TopRatedRouter()
            
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
