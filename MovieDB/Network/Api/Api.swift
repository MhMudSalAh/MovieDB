//
//  API.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

/**
 APIConfigurations: Application Modes
 This enum reflict the application modes which can application follow them.
 
 - parameter debug: For the application during the development phase.
 - parameter stage: For the application during the testing phase.
 - parameter release: For the application during the launching on the store.
 */

let API = Api(.development)

enum APIConfigurations: String {
    
    case development = "debug"
    case stage = "stage"
    case release = "release"
}

final class Api {
    
    let config: APIConfigurations
    
    var BASE_URL: String {
        switch config {
        case .development:
            return "https://api.themoviedb.org/3/"
        case .stage:
            return "https://api.themoviedb.org/3/"
        case .release:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    init(_ config: APIConfigurations) {
        self.config = config
    }
    
    // MARK:- IMAGE PATH
    
    let IMAGE_PATH = "https://image.tmdb.org/t/p/w500"
    
    // MARK:- USER
    
    let SERVICE_USER_PROFILE = "v1/user/profile"
    let SERVICE_USER_LOG_OUT = "v1/user/logout"
    let SERVICE_USER_RESET_PASSWORD = "v1/user/password/create"
    
    // MARK:- MOVIES
    
    let SERVICE_MOVIES_NOWPLAYING = "movie/now_playing"
    let SERVICE_MOVIES_TOP_RATED = "movie/top_rated"
    let SERVICE_MOVIES_DETAILS = "movie/"

}

extension Api {
    
    func getImagePath(_ path: String) -> String {
        return "\(API.IMAGE_PATH)\(path)"
    }
}


// MARK:- API Key (v3 auth)
//bc55d3258448176af1b20afb13344795


// MARK:- Example API Request
//https://api.themoviedb.org/3/movie/550?api_key=bc55d3258448176af1b20afb13344795


// MARK:- API Read Access Token (v4 auth)
//eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYzU1ZDMyNTg0NDgxNzZhZjFiMjBhZmIxMzM0NDc5NSIsInN1YiI6IjYxMzQ3YWE2ZmQ0YTk2MDA4NzUxZWUyZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XFLoDFlfkCM9XRj7GOCSK_NHqryFZ592tjDYuSFnhVk
