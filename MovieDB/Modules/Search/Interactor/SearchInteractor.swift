//
//  SearchInteractor.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
    
class SearchInteractor: SearchInteractorInterface {
        
    weak var output: SearchInteractorOutput?
    
    func doSearch(_ page: Int, _ text: String) {
        MOVIE.search(page, text) { response in
            switch response {
            case let .onSuccess(page):
                self.output?.didSearch(page)
            case let .onFailure(error):
                self.output?.didFailToSearch(error)
            case .onCompleted:
                break
            }
        }
    }
}
