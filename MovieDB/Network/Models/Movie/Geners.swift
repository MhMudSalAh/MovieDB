//
//  Geners.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

struct Geners: Codable  {
    
    var id: Int = 0
    var title: String? = ""
}

extension Geners {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title = "name"
    }
}
