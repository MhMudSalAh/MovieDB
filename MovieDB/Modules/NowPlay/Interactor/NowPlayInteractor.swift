//
//  NowPlayInteractor.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

class NowPlayInteractor: NowPlayInteractorInteface {

    var output: NowPlayInteractorOutput!
    
    func getNowPlaying(_ page: Int) {
        MOVIES.nowPlaying(page){ response in
            switch response {
            case let .onSuccess(page):
                self.output.didGetNowPlaying(page)
                break
            case let .onFailure(error):
                self.output.didFailToGetNowPlaying(error)
                break
            case .onCompleted:
                break
            }
        }
    }
}
