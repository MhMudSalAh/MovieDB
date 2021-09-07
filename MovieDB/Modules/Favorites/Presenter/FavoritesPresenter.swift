//
//  FavoritesPresenter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

class FavoritesPresenter: FavoritesPresenterInterface {
    
    weak var view: FavoritesView?
    var interactor: FavoritesInteractorInteface!
    var router: FavoritesRouterInterface!
    
    func getFavorites() {
        interactor.getFavorites()
    }
    
    func didSelectFavorite(_ movieId: Int) {
        router.presentMovieDetails(movieId)
    }
    
    func didClickToUnFavorite(_ movieId: Int) {
        interactor.deleteFromFavorite(movieId)
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
    
    func didGetFavorites(_ favorites: [Movie]) {
        DispatchQueue.main.async { [self] in
            view?.hideNetworkErrorScreen()
            view?.hideLoading()
            view?.favorites = favorites
        }
    }
    
    func didFailToGetFavorites(_ error: APIError) {
        DispatchQueue.main.async { [self] in
            view?.hideLoading()
            checkError(error)
        }
    }
    
    func didDeleteFavorite(_ favorites: [Movie]) {
        DispatchQueue.main.async { [self] in
            view?.hideNetworkErrorScreen()
            view?.hideLoading()
            view?.favorites = favorites
        }
    }
    
    func didFailToDeleteFavorite(_ error: APIError) {
        DispatchQueue.main.async { [self] in
            view?.hideLoading()
            checkError(error)
        }
    }
    
    func checkError(_ error: APIError) {
        view?.hideLoading()
        switch error.type {
        case .network:
            view?.presentNetworkErrorScreen()
        default:
            view?.presentNetworkErrorScreen()
        }
    }
}
