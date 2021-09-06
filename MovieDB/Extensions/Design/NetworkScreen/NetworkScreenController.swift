//
//  NetworkScreenController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

let NETWORKSCREEN = NetworkScreenController.shared

protocol NetworkScreenControllerDelegate {
    func didClickTypeAgain()
}

class NetworkScreenController: BaseController {
    
    @IBOutlet weak var lblErrorTitle: UILabel!
    @IBOutlet weak var lblErrorDescription: UILabel!
    @IBOutlet weak var btnNetworkError: LoadingButton!
    
    static var shared = NetworkScreenController()
    var delegate: NetworkScreenControllerDelegate?
    var isPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView() {
        setupError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    func setupError() {
        setup( "no_internet_connection", "error_description", "try_again")
    }
    
    func setup(_ title: String, _ description: String,_ btnTitle: String) {
        lblErrorTitle.text = localizedText(title)
        lblErrorDescription.text = localizedText(description)
        btnNetworkError.setTitle(btnTitle)
    }
    
    func showAsSubView(_ view: UIView) {
        isPresented = true
        DispatchQueue.main.async {
            self.view.frame = view.frame
            view.addSubview(self.view)
        }
    }
    
    func close() {
        isPresented = false
        DispatchQueue.main.async {
            self.view.removeFromSuperview()
        }
    }
    
    @IBAction func btnNetworkErrorAction(_ sender: Any) {
        delegate?.didClickTypeAgain()
    }
}
