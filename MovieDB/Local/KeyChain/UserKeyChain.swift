//
//  UserKeyChain.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  

import UIKit

class UserKeyChain: KeyChain {
    
    let key = "UserKeyChainData"
    
    static var shared = UserKeyChain()
    
    func save(user: User) {
        _ = store(key, user)
    }

    func get() -> User? {
        return load(key)
    }
    
    func isExist() -> Bool {
        return get() != nil
    }
    
    func logOut() {
        delete(key)
    }
}
