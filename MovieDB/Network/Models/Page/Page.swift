//
//  Page.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

class Page<T: Codable>: NSObject, Codable {
    
    var current: Int?
    var data: T?
    var totalPage: Int?
    var totalResult: Int?
    
    override init() {
        super.init()
    }
}

extension Page {
    
    enum CodingKeys: String, CodingKey {
        
        case current = "page"
        case data = "results"
        case totalPage = "total_pages"
        case totalResult = "total_results"
    }
}

