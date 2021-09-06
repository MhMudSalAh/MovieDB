//
//  SplashContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

protocol SplashView: AnyObject {
    var presenter: SplashPresenterInterface! { get set }
}

protocol SplashPresenterInterface: AnyObject {
    var view: SplashView? { get set }
    var interactor: SplashInteractorInteface! { get set }
    var router: SplashRouterInterface! { get set }
    
    func viewDidLoad()
}

protocol SplashInteractorInteface: AnyObject {
        
    var output: SplashInteractorOutput! { get set }
}

protocol SplashInteractorOutput: AnyObject {

}

protocol SplashRouterInterface: AnyObject {
    
    var viewController: UIViewController? { get set }
    
    func presentHome()
    
    static func assembleModule() -> UIViewController
}

