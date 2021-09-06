//
//  MoviesService.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import Foundation

extension Api {
    
    enum Movies: ServiceProtocol {
        
        case nowPlaying(_ page: Int)
        case topRated(_ page: Int)
        case details(_ movieId: Int)
        case search(_ page: Int, _ text: String)
        
        var path: String {
            switch self {
            case .nowPlaying:
                return API.SERVICE_MOVIES_NOWPLAYING
            case .topRated:
                return API.SERVICE_MOVIES_TOP_RATED
            case let .details(movieId):
                return "\(API.SERVICE_MOVIES_DETAILS)\(movieId)"
            case .search:
                return API.SERVICE_MOVIES_SEARCH
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .nowPlaying:
                return .GET
            case .topRated:
                return .GET
            case .details:
                return .GET
            case .search:
                return .GET
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case let .nowPlaying(page):
                return ["page": page]
            case let .topRated(page):
                return ["page": page]
            case .details:
                return nil
            case let .search(page, text):
                return ["page": page, "query": text]
            }
        }
        
        var headers: Headers? {
            switch self {
            case .nowPlaying:
                return nil
            case .topRated:
                return nil
            case .details:
                return nil
            case .search:
                return nil
            }
        }
        
        var body: Any? {
            switch self {
            case .nowPlaying:
                return nil
            case .topRated:
                return nil
            case .details:
                return nil
            case .search:
                return nil
            }
        }
    }
}

