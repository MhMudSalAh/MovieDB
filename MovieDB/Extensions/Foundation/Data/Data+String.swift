//
//  Data+String.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

public extension Data {
    
    /**
     Converts a data object to an utf8 string.
     
     - returns: The utf8 string or nil
     */
    var utf8String: String {
        return String(decoding: self, as: UTF8.self)
    }
}
