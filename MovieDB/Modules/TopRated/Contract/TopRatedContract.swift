//
//  TopRatedContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

protocol TopRatedView: AnyObject {
    var presenter: TopRatedPresenterInterface! { get set }
    var topRated: [Movie] { get set }
    var page: Paginate { get set }

    func showLoading()
    func hideLoading()
    func endIndicator()
    
    func presentNetworkErrorScreen()
    func hideNetworkErrorScreen()
}

protocol TopRatedPresenterInterface: AnyObject {
    var view: TopRatedView? { get set }
    var interactor: TopRatedInteractorInteface! { get set }
    var router: TopRatedRouterInterface! { get set }
    
    func getTopRated(_ page: Int)
}

protocol TopRatedInteractorInteface: AnyObject {
    var output: TopRatedInteractorOutput! { get set }
    
    func getTopRated(_ page: Int)
}

protocol TopRatedInteractorOutput: AnyObject {

    func didGetTopRated(_ page: Page<[Movie]>)
    func didFailToGetTopRated(_ error: APIError)
}

protocol TopRatedRouterInterface: AnyObject {
    
    var viewController: UIViewController? { get set }
        
    static func assembleModule() -> UIViewController
}
