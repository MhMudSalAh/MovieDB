//
//  Token.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

class Token: NSObject, NSCoding, Codable {
    
    var type: String = ""
    var access: String = ""
    var date: String = ""
    
    override init() {
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(type, forKey: "token_type")
        coder.encode(access, forKey: "access_token")
        coder.encode(date, forKey: "expires_at")
    }
    
    required init?(coder: NSCoder) {
        self.type = coder.decodeObject(forKey: "token_type") as! String
        self.access = coder.decodeObject(forKey: "access_token") as! String
        self.date = coder.decodeObject(forKey: "expires_at") as! String
    }
}

extension Token {
    
    enum CodingKeys: String, CodingKey {
        
        case type = "token_type"
        case access = "access_token"
        case date = "expires_at"
    }
}
