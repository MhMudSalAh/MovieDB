//
//  NowPlayingService.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

extension Api {
    
    enum Movies: ServiceProtocol {
        
        case nowPlaying(_ page: Int)
        case topRated
        case details
        
        var path: String {
            switch self {
            case .nowPlaying:
                return API.SERVICE_MOVIES_NOWPLAYING
            case .topRated:
                return API.SERVICE_MOVIES_TOP_RATED
            case .details:
                return API.SERVICE_MOVIES_DETAILS
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .nowPlaying:
                return .GET
            case .topRated:
                return .POST
            case .details:
                return .POST
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case let .nowPlaying(page):
                return ["page" : page]
            case .topRated:
                return nil
            case .details:
                return nil
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
            }
        }
    }
}

