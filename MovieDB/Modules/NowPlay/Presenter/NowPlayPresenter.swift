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
}

extension NowPlayPresenter: NowPlayInteractorOutput {

    func didGetNowPlaying(_ page: Page<[Movie]>) {
        DispatchQueue.main.async { [self] in
            view?.hideLoading()
            view?.hideNetworkErrorScreen()
            view?.page.current = page.current ?? 1
            view?.page.last = page.totalPage ?? 1
            if page.current == 1 {
                let data = page.data ?? []
                view?.nowPlaying = data
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
        case .network, .server, .parsing:
            view?.presentNetworkErrorScreen()
        default:
            //MARK TO DO
            break
        }
    }
}
