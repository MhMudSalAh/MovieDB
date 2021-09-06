//
//  MoviesRepository.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

let MOVIES = MoviesRepository.shared

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
}

