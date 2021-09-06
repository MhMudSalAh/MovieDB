//
//  NowPlayContract.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

protocol NowPlayView: AnyObject {
    var presenter: NowPlayPresenterInterface! { get set }
    var nowPlaying: [Movie] { get set }
    var page: Paginate { get set }

    func showLoading()
    func hideLoading()
    
    func presentNetworkErrorScreen()
    func hideNetworkErrorScreen()
}

protocol NowPlayPresenterInterface: AnyObject {
    var view: NowPlayView? { get set }
    var interactor: NowPlayInteractorInteface! { get set }
    var router: NowPlayRouterInterface! { get set }
    
    func getNowPlaying(_ page: Int)
}

protocol NowPlayInteractorInteface: AnyObject {
    var output: NowPlayInteractorOutput! { get set }
    
    func getNowPlaying(_ page: Int)
}

protocol NowPlayInteractorOutput: AnyObject {
    
    func didGetNowPlaying(_ page: Page<[Movie]>)
    func didFailToGetNowPlaying(_ error: APIError)
}

protocol NowPlayRouterInterface: AnyObject {
    
    var viewController: UIViewController? { get set }
        
    static func assembleModule() -> UIViewController
}
