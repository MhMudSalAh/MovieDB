//
//  FavoritesInteractor.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import Foundation

class FavoritesInteractor: FavoritesInteractorInteface {

    var output: FavoritesInteractorOutput!
    
    func getFavorites() {
        FAVORITE.get(){ response in
            switch response {
            case let .onSuccess(movies):
                self.output.didGetFavorites(movies)
            case let .onFailure(error):
                self.output.didFailToGetFavorites(error)
            case .onCompleted:
                break
            }
        }
    }
    
    func deleteFromFavorite(_ movieId: Int) {
        FAVORITE.delete(movieId) { response in
            switch response {
            case let .onSuccess(movies):
                self.output.didDeleteFavorite(movies)
            case let .onFailure(error):
                self.output.didFailToDeleteFavorite(error)
            case .onCompleted:
                break
            }
        }
    }

}
