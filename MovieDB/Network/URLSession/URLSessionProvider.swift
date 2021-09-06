//
//  URLSessionProvider.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  Copyright © 2019 Tarseya. All rights reserved.
//

import UIKit
import SystemConfiguration

let NETWORK = URLSessionProvider.shared

final class URLSessionProvider: URLSessionProviderProtocol {

    static var shared = URLSessionProvider()
    
    private var session: URLSessionProtocol
    private let REQUEST_TIME = 80.00
    private var online = false
    private let imageCache = NSCache<NSString, UIImage>()
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func urlCahcePolicy(_ isCache: Bool) -> URLRequest.CachePolicy {
        online = Reachability.isOnline()
        return isCache ? (online ? .reloadIgnoringCacheData : .returnCacheDataDontLoad) : .reloadIgnoringCacheData
    }
    
    func request<T>(type: T.Type?, service: ServiceProtocol, completion: @escaping (APIResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service, cachePolicy: urlCahcePolicy(/* MARK: Enable Cache */ true), timeoutInterval: REQUEST_TIME)
        
        var task: URLSessionDataTask? = nil
        task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            
            #if DEBUG
            // MARK: Console Action
            self?.info(task!, request.httpBody, data, response, error)
            #endif
            
            self?.handleResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task?.resume()
    }
    
    func handleResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (APIResponse<T>) -> ()) {
        guard error == nil else {
            // MARK: UI Action
            let apiError = APIError(type: online ? .server : .network)
            Console.logError(apiError.type)
            return completion(.failure(apiError))
        }
        
        guard let response = response else {
            // MARK: UI Action
            let apiError = APIError(type: .noData)
            Console.logError(apiError.type)
            return completion(.failure(apiError))
        }
        
        guard let apiData = data, let result = try? JSONDecoder().decode((T).self, from: apiData) else {
            // MARK: UI Action
            let apiError = APIError(type: .parsing)
            Console.logError(apiError.type)
            return completion(.failure(apiError))
        }
        
        switch response.statusCode {
        case 200...299:
            completion(.success(result))
        default:
            let apiError = APIError(code: response.statusCode, message: localizedText("error"), errors: Errors(), type: .known)
            Console.logError(apiError.type)
            completion(.failure(apiError))
        }
    }
    
    func info(_ task: URLSessionDataTask, _ body: Any?, _ data: Data?, _ response: URLResponse?, _ error: Error?) {
        let url: String = task.originalRequest?.url?.absoluteString ?? ""
        let headers: [String: String] = task.originalRequest?.allHTTPHeaderFields ?? [:]
        let statusCode: Int = (task.response as? HTTPURLResponse)?.statusCode ?? 0
        let response: String = String(data: data ?? Data(), encoding: .utf8) ?? ""
        Console.logAPI(url, headers, body as Any, statusCode, response, error)
    }
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> ()) {
        let cacheKey = NSString(string: url)
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
        } else {
            guard let url = URL(string: url) else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self,
                      error == nil,
                      let data = data,
                      let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode),
                      let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(image, forKey: cacheKey)
                completion(image)
            }
            task.resume()
        }
    }
}

