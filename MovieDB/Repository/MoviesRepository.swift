//
//  MoviesRepository.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

let MOVIE = MoviesRepository.shared

class MoviesRepository: Repo {
    
    static let shared = MoviesRepository()
    
    func nowPlaying(_ page: Int, _ completion: @escaping (Response<Page<[Movie]>>) -> ()) {
        provider.request(type: Page<[Movie]>.self, service: Api.Movies.nowPlaying(page)) { response in
            switch response {
            case let .success(page):
                completion(.onSuccess(page))
            case let .failure(error):
                completion(.onFailure(error))
            case .complete:
                completion(.onCompleted)
                break
            }
        }
    }
    
    func topRated(_ page: Int, _ completion: @escaping (Response<Page<[Movie]>>) -> ()) {
        provider.request(type: Page<[Movie]>.self, service: Api.Movies.topRated(page)) { response in
            switch response {
            case let .success(page):
                completion(.onSuccess(page))
            case let .failure(error):
                completion(.onFailure(error))
            case .complete:
                completion(.onCompleted)
                break
            }
        }
    }
    
    func details(_ movieId: Int, _ completion: @escaping (Response<Movie>) -> ()) {
        provider.request(type: Movie.self, service: Api.Movies.details(movieId)) { response in
            switch response {
            case let .success(movie):
                completion(.onSuccess(self.checkFavoriteMovie(movie)))
            case let .failure(error):
                completion(.onFailure(error))
            case .complete:
                completion(.onCompleted)
                break
            }
        }
    }
    
    func search(_ page: Int, _ text: String, _ completion: @escaping (Response<Page<[Movie]>>) -> ()) {
        provider.request(type: Page<[Movie]>.self, service: Api.Movies.search(page, text)) { response in
            switch response {
            case let .success(page):
                completion(.onSuccess(page))
                break
            case let .failure(error):
                completion(.onFailure(error))
                break
            case .complete:
                completion(.onCompleted)
                break
            }
        }
    }
    
    func checkFavoriteMovie(_ movie: Movie) -> Movie {
        if !FAVORITE.favorites.isEmpty {
            if let _ = FAVORITE.favorites.firstIndex(where: {$0.id == movie.id}) {
                movie.favorite = true
            } else {
                movie.favorite = false
            }
        } else {
            movie.favorite = false
        }
        return movie
    }
}
