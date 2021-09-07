//
//  FavoritesContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

protocol FavoritesView: AnyObject {
    var presenter: FavoritesPresenterInterface! { get set }
    var favorites: [Movie] { get set }

    func showLoading()
    func hideLoading()
    
    func presentNetworkErrorScreen()
    func hideNetworkErrorScreen()
}

protocol FavoritesPresenterInterface: AnyObject {
    var view: FavoritesView? { get set }
    var interactor: FavoritesInteractorInteface! { get set }
    var router: FavoritesRouterInterface! { get set }
    
    func getFavorites()
    func didSelectFavorite(_ movieId: Int)
    func didClickToUnFavorite(_ movieId: Int)
}

protocol FavoritesInteractorInteface: AnyObject {
    var output: FavoritesInteractorOutput! { get set }
    
    func getFavorites()
    func deleteFromFavorite(_ movieId: Int)
}

protocol FavoritesInteractorOutput: AnyObject {
    
    func didGetFavorites(_ favorites: [Movie])
    func didFailToGetFavorites(_ error: APIError)
    
    func didDeleteFavorite(_ favorites: [Movie])
    func didFailToDeleteFavorite(_ error: APIError)
}

protocol FavoritesRouterInterface: AnyObject {
    var viewController: UIViewController? { get set }
    
    func presentMovieDetails(_ movieId: Int)
    
    static func assembleModule() -> UIViewController
}
