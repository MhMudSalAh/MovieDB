//
//  TopRatedContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

protocol TopRatedView: AnyObject {
    var presenter: TopRatedPresenterInterface! { get set }
}

protocol TopRatedPresenterInterface: AnyObject {
    var view: TopRatedView? { get set }
    var interactor: TopRatedInteractorInteface! { get set }
    var router: TopRatedRouterInterface! { get set }
    
}

protocol TopRatedInteractorInteface: AnyObject {
        
    var output: TopRatedInteractorOutput! { get set }
}

protocol TopRatedInteractorOutput: AnyObject {

}

protocol TopRatedRouterInterface: AnyObject {
    
    var viewController: UIViewController? { get set }
        
    static func assembleModule() -> UIViewController
}
