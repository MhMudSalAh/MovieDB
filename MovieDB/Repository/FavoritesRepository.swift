//
//  FavoritesRepository.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

let FAVORITE = FavoritesRepository.shared


class FavoritesRepository: Repo {
    
    static let shared = FavoritesRepository()
    let NOTIFICATION_CENTER_ID = "favouritesNotification"
    
    var favorites: [Movie] = [] {
        didSet {
            observeFavouriets()
        }
    }
    
    func sync() {
        get { response in
            switch response {
            case .onSuccess, .onCompleted:
                break
            case .onFailure:
                break
            }
        }
    }
    
    func get(_ completion: @escaping (Response<[Movie]>) -> ()) {
        self.favorites = FavoritesManager().retrieve() ?? []
        completion(.onSuccess(favorites))
        completion(.onCompleted)
    }
    
    func add(_ movie: Movie, _ completion: @escaping (Response<[Movie]>) -> ()) {
        if favorites.isEmpty {
            _ = FavoritesManager().store(movie)
            self.favorites = FavoritesManager().retrieve() ?? []
            completion(.onSuccess(favorites))
            completion(.onCompleted)
        } else {
            if let _ = FAVORITE.favorites.firstIndex(where: {$0.id != movie.id}) {
                _ = FavoritesManager().store(movie)
                self.favorites = FavoritesManager().retrieve() ?? []
                completion(.onSuccess(favorites))
                completion(.onCompleted)
            }
        }
    }
    
    func delete(_ movieId: Int, _ completion: @escaping (Response<[Movie]>) -> ()) {
        FavoritesManager().delete(movieId)
        self.favorites = FavoritesManager().retrieve() ?? []
        completion(.onSuccess(favorites))
        completion(.onCompleted)
    }
    
    func observeFavouriets() {
        NotificationCenter.default.post(name: Notification.Name(self.NOTIFICATION_CENTER_ID), object: nil)
    }
}
