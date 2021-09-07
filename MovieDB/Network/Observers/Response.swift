//
//  Response.swift
//  Network Layer
//
//  Created by MhMuD SalAh on 10/16/19.
//  

enum Response<T> {

    case onSuccess(T)
    case onFailure(APIError)
    case onCompleted
}
