//
//  TopRatedInteractor.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

class TopRatedInteractor: TopRatedInteractorInteface {

    var output: TopRatedInteractorOutput!
    
    func getTopRated(_ page: Int) {
        MOVIE.topRated(page){ response in
            switch response {
            case let .onSuccess(page):
                self.output.didGetTopRated(page)
            case let .onFailure(error):
                self.output.didFailToGetTopRated(error)
            case .onCompleted:
                break
            }
        }
    }
}
