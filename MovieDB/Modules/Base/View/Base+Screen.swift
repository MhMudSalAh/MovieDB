//
//  Base+Screen.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

// MARK:- Network Screen

extension BaseController {
    
    func showNetworkErrorScreen(_ delegate: NetworkScreenControllerDelegate?, _ view: UIView) {
        isNetworkScreenPresented = true
        NETWORKSCREEN.delegate = delegate
        NETWORKSCREEN.showAsSubView(view)
    }
    
    func closeNetworkErrorScreen() {
        isNetworkScreenPresented = false
        if NETWORKSCREEN.isPresented {
            NETWORKSCREEN.close()
        }
    }
    
    func checkNetworkError(_ apiFunction: () -> Void) {
        if isNetworkScreenPresented ?? false && !NETWORKSCREEN.isPresented {
            apiFunction()
        }
    }
}

// MARK:- Empty Screen

extension BaseController {
    
    func showEmptyScreen(_ type: EmptyScreenType, _ delegate: EmptyScreenControllerDelegate?, _ view: UIView) {
        if !emptyScreen.isPresented {
            emptyScreen.type = type
            emptyScreen.delegate = delegate
            emptyScreen.showAsSubView(view)
        }
    }
    
    func closeEmptyScreen() {
        if emptyScreen.isPresented{
            emptyScreen.close()
        }
    }
}
