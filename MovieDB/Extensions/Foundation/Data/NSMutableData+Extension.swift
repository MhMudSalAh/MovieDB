//
//  NSMutableData+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

extension Data {

    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
