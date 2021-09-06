//
//  ServiceProtocol.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  Copyright © 2019 Tarseya. All rights reserved.
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
