//
//  NavController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

var NAV = NavController.shared

class NavController: UINavigationController {
    
    static var shared: NavController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavController.shared = self
        NAV = NavController.shared
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavController.shared = self
        NAV = NavController.shared
    }
}
