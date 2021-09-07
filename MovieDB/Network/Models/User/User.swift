//
//  User.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  

import Foundation

class User: NSObject, NSCoding, Codable {

    var id: Int = 0
    var name: String = ""
    var email: String? = ""
    var phone: String? = ""
    var image: String? = ""
    var pending: Int? = 0
    var block: Int? = 0
    var userType: Int? = 0
    var roleId: Int? = 0
    
    override init() {
        super.init()
    }
    
    func imageURL(thumbnail: Bool? = false) -> String? {
        if let image = image { return API.getImagePath(image) }
        return nil
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "username")
        coder.encode(email, forKey: "email")
        coder.encode(phone, forKey: "phone")
        coder.encode(image, forKey: "image")
        coder.encode(pending, forKey: "pending")
        coder.encode(block, forKey: "block")
        coder.encode(userType, forKey: "user_type")
        coder.encode(roleId, forKey: "role_id")
        coder.encode(userType, forKey: "user_type")
        coder.encode(roleId, forKey: "role_id")
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? Int ?? 0
        self.name = coder.decodeObject(forKey: "username") as? String ?? ""
        self.email = coder.decodeObject(forKey: "email") as? String ?? ""
        self.phone = coder.decodeObject(forKey: "phone") as? String ?? ""
        self.image = coder.decodeObject(forKey: "image") as? String
        self.pending = coder.decodeObject(forKey: "pending") as? Int
        self.block = coder.decodeObject(forKey: "block") as? Int
        self.userType = coder.decodeObject(forKey: "user_type") as? Int
        self.roleId = coder.decodeObject(forKey: "role_id") as? Int
    }
}

extension User {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name = "username"
        case email
        case phone
        case image
        case pending
        case block
        case userType = "user_type"
        case roleId = "role_id"
    }
}


