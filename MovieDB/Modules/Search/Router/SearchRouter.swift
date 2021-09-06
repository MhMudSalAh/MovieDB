//
//  SearchRouter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

class SearchRouter: SearchRouterInterface {
 
    weak var viewController: UIViewController?
         
    static func assembleModule() -> UIViewController {
        let view: SearchController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchController") as! SearchController
            
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        
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
