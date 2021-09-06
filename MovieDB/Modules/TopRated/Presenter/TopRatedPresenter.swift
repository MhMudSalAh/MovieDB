//
//  TopRatedPresenter.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class TopRatedPresenter: TopRatedPresenterInterface {

    weak var view: TopRatedView?
    var interactor: TopRatedInteractorInteface!
    var router: TopRatedRouterInterface!
    
}

extension TopRatedPresenter: TopRatedInteractorOutput {

}
