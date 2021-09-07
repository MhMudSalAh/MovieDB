//
//  MovieDetailsInteractor.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import Foundation

class MovieDetailsInteractor: MovieDetailsInteractorInteface {
    
    var output: MovieDetailsInteractorOutput!
    
    func getMovie(_ movieId: Int) {
        MOVIE.details(movieId){ response in
            switch response {
            case let .onSuccess(page):
                self.output.didGetMovie(page)
            case let .onFailure(error):
                self.output.didFailToGetMovie(error)
            case .onCompleted:
                break
            }
        }
    }
    
    func addToFavourite(_ movie: Movie) {
        FAVORITE.add(movie) { response in
            switch response {
            case .onCompleted:
                break
            default:
                break
            }
        }
    }
    
    func deleteFromFavourite(_ movieId: Int) {
        FAVORITE.delete(movieId) { response in
            switch response {
            case .onCompleted:
                break
            default:
                break
            }
        }
    }
}
