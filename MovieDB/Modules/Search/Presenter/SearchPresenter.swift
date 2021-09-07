//
//  SearchPresenter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

class SearchPresenter: SearchPresenterInterface {

    weak var view: SearchView?
    var router: SearchRouterInterface!
    var interactor: SearchInteractorInterface!
    
    func doSearch(_ page: Int, _ text: String) {
        if page == 1 {
            view?.showLoading()
        }
        interactor.doSearch(page, text)
    }
    
    func didSelectMovie(_ movieId: Int) {
        router.presentMovieDetails(movieId)
    }
}
    
extension SearchPresenter: SearchInteractorOutput {
    
    func didSearch(_ page: Page<[Movie]>) {
        DispatchQueue.main.async { [self] in
            view?.page.current = page.current ?? 1
            view?.page.last = page.totalPage ?? 1
            view?.hideNetworkErrorScreen()
            view?.hideLoading()
            if page.current == 1 {
                view?.movies = page.data ?? []
            } else {
                view?.movies.append(contentsOf: page.data ?? [])
            }
        }
    }
    
    func didFailToSearch(_ error: APIError) {
        DispatchQueue.main.async {
            self.view?.hideLoading()
            self.checkError(error)
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
