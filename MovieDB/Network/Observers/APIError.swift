//
//  APIError.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  Copyright © 2019 Tarseya. All rights reserved.
//

enum APIErrorType {

    case server
    case noData
    case parsing
    case string
    case network
    case known
}

struct APIError {
    
    var code: Int? = 0
    var message: String?
    var errors: Errors?
    var type: APIErrorType
}


struct Errors: Codable {
    
    var message: String?
}

extension Errors {
    
    enum CodingKeys: String, CodingKey {
        
        case message
    }
}
