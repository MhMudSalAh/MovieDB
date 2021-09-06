//
//  TokenKeyChain.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class TokenKeyChain: KeyChain {
    
    let key = "TokenKeyChainData"
    
    static var shared = TokenKeyChain()
    
    func save(token: Token) {
        _ = store(key, token)
    }

    func get() -> Token? {
        return load(key)
    }
    
    func isExist() -> Bool {
        return get() != nil
    }
    
    func delete() {
        delete(key)
    }
}
