//
//  TopRatedPresenter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class TopRatedPresenter: TopRatedPresenterInterface {

    weak var view: TopRatedView?
    var interactor: TopRatedInteractorInteface!
    var router: TopRatedRouterInterface!
    
    func getTopRated(_ page: Int) {
        if page == 1 {
            view?.showLoading()
        }
        interactor.getTopRated(page)
    }
    
    func didSelectMovie(_ movieId: Int) {
        router.presentMovieDetails(movieId)
    }
}

extension TopRatedPresenter: TopRatedInteractorOutput {

    func didGetTopRated(_ page: Page<[Movie]>) {
        DispatchQueue.main.async { [self] in
            view?.page.current = page.current ?? 1
            view?.page.last = page.totalPage ?? 1
            view?.hideNetworkErrorScreen()
            view?.hideLoading()
            view?.endIndicator()
            if page.current == 1 {
                view?.topRated = page.data ?? []
            } else {
                view?.topRated.append(contentsOf: page.data ?? [])
            }
        }
    }
    
    func didFailToGetTopRated(_ error: APIError) {
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
