//
//  URLComponents+Extension.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  

import Foundation

extension URLComponents {
    
    init(service: ServiceProtocol) {
        let urlString = API.BASE_URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let baseUrl = URL(string: urlString)
        let url = baseUrl!.appendingPathComponent(service.path)
        
        self.init(url: url, resolvingAgainstBaseURL: false)!

        /// Set the spasific guery params which assigned by routes
        
        var parameters = service.parameters ?? [:]
        parameters.updateValue(LOCAL.getLanguage(), forKey: APIHeader.language.rawValue)
        parameters.updateValue(APIHeader.apiValue.rawValue, forKey: APIHeader.apiKey.rawValue)
        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}

