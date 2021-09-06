//
//  SplashController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class SplashController: BaseController {
    
    var presenter: SplashPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SplashController: SplashView {
    
}

 
