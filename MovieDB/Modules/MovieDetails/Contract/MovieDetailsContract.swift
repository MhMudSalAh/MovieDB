//
//  MovieDetailsContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

protocol MovieDetailsView: AnyObject {
    var presenter: MovieDetailsPresenterInterface! { get set }
    var movie: Movie { get set }
    
    func showLoading()
    func hideLoading()
    
    func presentNetworkErrorScreen()
    func hideNetworkErrorScreen()
}

protocol MovieDetailsPresenterInterface: AnyObject {
    var view: MovieDetailsView? { get set }
    var interactor: MovieDetailsInteractorInteface! { get set }
    var router: MovieDetailsRouterInterface! { get set }
    
    func getMovie(_ movieId: Int)
    func didClickFavorite(_ movie: Movie)
    func didClickToBack()
}

protocol MovieDetailsInteractorInteface: AnyObject {
    var output: MovieDetailsInteractorOutput! { get set }
    
    func getMovie(_ movieId: Int)
    func addToFavourite(_ movie: Movie)
    func deleteFromFavourite(_ movieId: Int)
}

protocol MovieDetailsInteractorOutput: AnyObject {
    
    func didGetMovie(_ movie: Movie)
    func didFailToGetMovie(_ error: APIError)
}

protocol  MovieDetailsRouterInterface: AnyObject {
    var viewController: UIViewController? { get set }
        
    func popViewController()
    
    static func assembleModule(_ movieId: Int) -> UIViewController
}
