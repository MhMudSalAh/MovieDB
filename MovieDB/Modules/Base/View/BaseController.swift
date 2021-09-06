//
//  BaseController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class BaseController: UIViewController {
    
    var emptyScreen: EmptyScreenController = EmptyScreenController()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshTable = UIRefreshControl()
    var refreshCollection = UIRefreshControl()
    var isNetworkScreenPresented: Bool? = false
    let greyView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTable.tintColor = .primary
        refreshCollection.tintColor = .primary
        setupBackNavigation()
     }    
}
