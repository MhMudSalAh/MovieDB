//
//  SplashRouter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class SplashRouter: SplashRouterInterface {
    
    weak var viewController: UIViewController?
    
    func presentHome() {
        TAB.selectedIndex = 0
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        appDlg?.window?.rootViewController = TAB
    }
    
    static func assembleModule() -> UIViewController {
        let view: SplashController = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashController") as! SplashController
        
        let presenter = SplashPresenter()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
