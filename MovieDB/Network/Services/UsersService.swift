//
//  UserService.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

extension Api {
    
    enum Users: ServiceProtocol {
        
        case profile
        case logout
        case resetPassword(_ email: String)
        
        var path: String {
            switch self {
            case .profile:
                return API.SERVICE_USER_PROFILE
            case .logout:
                return API.SERVICE_USER_LOG_OUT
            case .resetPassword:
                return API.SERVICE_USER_RESET_PASSWORD
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .profile:
                return .GET
            case .logout:
                return .POST
            case .resetPassword:
                return .POST
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            case .profile:
                return nil
            case .logout:
                return nil
            case .resetPassword:
                return nil
            }
        }
        
        var headers: Headers? {
            switch self {
            case .profile:
                return nil
            case .logout:
                return nil
            case .resetPassword:
                return nil
            }
        }
        
        var body: Any? {
            switch self {
            case .profile:
                return nil
            case .logout:
                return nil
            case let .resetPassword(email):
                return ["email": email]
            }
        }
    }
}

