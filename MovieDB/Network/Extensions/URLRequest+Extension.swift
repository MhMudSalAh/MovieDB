//
//  URLRequest+Extension.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  

import UIKit
import SystemConfiguration

extension URLRequest {
    
    init(service: ServiceProtocol, cachePolicy: CachePolicy, timeoutInterval: TimeInterval) {
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        httpMethod = service.method.rawValue
        
        /// Set the spasific headers which assigned by routes
        
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        /// Set the generic headers which are global for any route
                        
        guard let body = service.body else { return }
        if ((body as? Data) != nil) && service.method == .POST && (service.headers?.firstIndex(where: {$0.key == APIHeader.contentLenght.rawValue}) != nil) {
            httpBody = service.body as? Data
        } else {
            guard let dic = (body as! Codable).asDictionary() else { return }
            httpBody = try? JSONSerialization.data(withJSONObject: dic)
        }
    }
}
