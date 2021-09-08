//
//  EmptyScreenController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

enum EmptyScreenType {
    
    case favourites
    case searchEmpty
    case search
}

@objc protocol EmptyScreenControllerDelegate {
    @objc optional func didClickEmptyScreenBtn()
}

class EmptyScreenController: UIViewController {
    
    @IBOutlet weak var emptyScreenImage: UIImageView!
    @IBOutlet weak var constrainWidthImage: NSLayoutConstraint!
    @IBOutlet weak var lblEmptyScreenTitle: UILabel!
    @IBOutlet weak var lblEmptyScreenDescription: UILabel!
    @IBOutlet weak var btnEmptyScreen: LoadingButton!
    
    var type: EmptyScreenType = EmptyScreenType.favourites
    var delegate: EmptyScreenControllerDelegate?
    var isPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        switch type {
        case .favourites:
            setupFavourites()
        case .searchEmpty:
            setupEmptySearch()
        case .search:
            setupSearch()
        }
    }
    
    func setup(_ title: String, _ description: String,_ imageKey: String, _ isBtnHidden: Bool,_ btnTitle: String?) {
        emptyScreenImage.image = UIImage(named: imageKey)
        lblEmptyScreenTitle.text = localizedText(title)
        lblEmptyScreenDescription.text = localizedText(description)
        btnEmptyScreen.isHidden = isBtnHidden
        btnEmptyScreen.btnDefault(titleKey: btnTitle)
    }
    
    func showAsSubView(_ view: UIView) {
        DispatchQueue.main.async {
            self.view.frame = view.frame
            view.addSubview(self.view)
        }
        isPresented = true
    }
    
    func close() {
        DispatchQueue.main.async {
            self.view.removeFromSuperview()
        }
        isPresented = false
    }
    
    @IBAction func btnEmptyScreenAction(_ sender: Any) {
        delegate?.didClickEmptyScreenBtn?()
    }
}

// MARK: Setup Empty Screen With Different Types

extension EmptyScreenController {
    
    func setupFavourites() {
        setup("empty_favorites_title", "empty_favorites_description", "favouritesPlaceholder", true, nil)
    }
    
    func setupEmptySearch() {
        constrainWidthImage.constant = 50
        setup("empty_search_title", "empty_search_description", "search", true, nil)
    }
    
    func setupSearch() {
        constrainWidthImage.constant = 50
        setup("search_title", "", "search", true, nil)
    }
}
