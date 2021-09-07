//
//  NowPlayPresenter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class NowPlayPresenter: NowPlayPresenterInterface {

    weak var view: NowPlayView?
    var interactor: NowPlayInteractorInteface!
    var router: NowPlayRouterInterface!
    
    func getNowPlaying(_ page: Int) {
        if page == 1 {
            view?.showLoading()
        }
        interactor.getNowPlaying(page)
    }
    
    func didSelectMovie(_ movieId: Int) {
        router.presentMovieDetails(movieId)
    }
}

extension NowPlayPresenter: NowPlayInteractorOutput {

    func didGetNowPlaying(_ page: Page<[Movie]>) {
        DispatchQueue.main.async { [self] in
            view?.page.current = page.current ?? 1
            view?.page.last = page.totalPage ?? 1
            view?.hideNetworkErrorScreen()
            view?.hideLoading()
            if page.current == 1 {
                view?.nowPlaying = page.data ?? []
            } else {
                view?.nowPlaying.append(contentsOf: page.data ?? [])
            }
        }
    }
    
    func didFailToGetNowPlaying(_ error: APIError) {
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
