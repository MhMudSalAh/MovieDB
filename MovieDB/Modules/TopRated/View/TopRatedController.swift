//
//  TopRatedController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class TopRatedController: BaseController {
    
    var presenter: TopRatedPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupNavigationTitle()
    }
    
    func setupNavigationTitle() {
        navigationItem.title = localizedText("top-rated")
    }
}

extension TopRatedController: TopRatedView {
    
}
