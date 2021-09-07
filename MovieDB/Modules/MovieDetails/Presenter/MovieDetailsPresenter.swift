//
//  MovieDetailsPresenter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

class MovieDetailsPresenter: MovieDetailsPresenterInterface {

    weak var view: MovieDetailsView?
    var interactor: MovieDetailsInteractorInteface!
    var router: MovieDetailsRouterInterface!
    
    func getMovie(_ movieId: Int) {
        view?.showLoading()
        interactor.getMovie(movieId)
    }
    
    func didClickToBack() {
        router.popViewController()
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutput {

    func didGetMovie(_ movie: Movie) {
        DispatchQueue.main.async { [self] in
            view?.hideNetworkErrorScreen()
            view?.hideLoading()
            view?.movie = movie
        }
    }
    
    func didFailToGetMovie(_ error: APIError) {
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
