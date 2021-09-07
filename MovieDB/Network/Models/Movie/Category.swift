//
//  Category.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

class Category: NSObject, Codable  {
    
    var id: Int = 0
    var title: String? = ""
    
    override init() {
        super.init()
    }
}

extension Category {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title = "name"
    }
}
