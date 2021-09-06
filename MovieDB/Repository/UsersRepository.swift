//
//  UsersRepository.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

let USER = UsersRepository.shared
    
class UsersRepository: Repo {
    
    let local = UserKeyChain.shared
    let token = TokenKeyChain.shared
    
    static let shared = UsersRepository()
    
    func get() {
        USER.profile { response in
            switch response {
            case .onSuccess, .onCompleted:
                break
            case .onFailure:
                break
            }
        }
    }
    
    func profile(_ completion: @escaping (Response<User>) -> ()) {
        provider.request(type: User.self, service: Api.Users.profile) { response in
            switch response {
            case let .success(user):
                self.local.save(user: user)
                completion(.onSuccess(user))
            case let .failure(error):
                completion(.onFailure(error))
            case .complete:
                completion(.onCompleted)
                break
            }
        }
    }
    
    
    func logOut(_ completion: @escaping (Response<AnyCodable>) -> ()) {
        provider.request(type: AnyCodable.self, service: Api.Users.logout) { response in
            DispatchQueue.main.async {
                self.token.delete()
                self.local.logOut()
            }
            switch response {
            case let .success(any):
                completion(.onSuccess(any))
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
    
    func resetPassword(_ email: String, _ completion: @escaping (Response<AnyCodable>) -> ()) {
        provider.request(type: AnyCodable.self, service: Api.Users.resetPassword(email)) { response in
            switch response {
            case let .success(any):
                self.local.logOut()
                completion(.onSuccess(any))
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
        
    func isExist() -> Bool {
        return token.isExist()
    }
}

