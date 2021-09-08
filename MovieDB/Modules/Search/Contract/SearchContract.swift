//
//  SearchContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

protocol SearchView: AnyObject {
    var presenter: SearchPresenterInterface! { get set }
    var movies: [Movie] { get set }
    var page: Paginate { get set }
    
    func showLoading()
    func hideLoading()
    
    func presentEmptyScreen()
    func hideSeacrhScreen()
    
    func presentNetworkErrorScreen()
    func hideNetworkErrorScreen()
}

protocol SearchPresenterInterface: AnyObject {
    var view: SearchView? { get set }
    var router: SearchRouterInterface! { get set }
    var interactor: SearchInteractorInterface! { get set }
    
    func doSearch(_ page: Int, _ text: String)
    func didSelectMovie(_ movieId: Int)
}

protocol SearchInteractorInterface: AnyObject {
    var output: SearchInteractorOutput? { get set }
    
    func doSearch(_ page: Int, _ text: String)
}

protocol SearchInteractorOutput: AnyObject {
    
    func didSearch(_ page: Page<[Movie]>)
    func didFailToSearch(_ error: APIError)
}

protocol SearchRouterInterface: AnyObject {
    var viewController: UIViewController? { get set }
        
    func presentMovieDetails(_ movieId: Int)
    
    static func assembleModule() -> UIViewController
}
