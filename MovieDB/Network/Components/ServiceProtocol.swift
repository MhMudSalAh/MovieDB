//
//  ServiceProtocol.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  

import Foundation

typealias Headers = [String : String]
typealias Parameters = [String : Any]

protocol ServiceProtocol {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: Headers? { get }
    var body: Any? { get }
}
