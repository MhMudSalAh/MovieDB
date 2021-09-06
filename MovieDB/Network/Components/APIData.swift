//
//  APIData.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

/// The generic response for current API

struct APIData<T: Decodable>: Decodable {
    
    var status: Bool?
    var message: String?
    var errors: Errors?
    var data: T?
}
