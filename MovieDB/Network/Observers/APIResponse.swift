//
//  APIResponse.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
// 

enum APIResponse<T> {
    
    case success(T)
    case failure(APIError)
    case complete
}
