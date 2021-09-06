//
//  EmptyScreenController.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

enum EmptyScreenType {
    
    case favourites
    case signToAddToFavourites
    case cart
    case search
    case products
    case orders
    case area
    case addresses
}

@objc protocol EmptyScreenControllerDelegate {
    @objc optional func didClickEmptyScreenBtn()
}

class EmptyScreenController: UIViewController {
    
    @IBOutlet weak var emptyScreenImage: UIImageView!
    @IBOutlet weak var lblEmptyScreenTitle: UILabel!
    @IBOutlet weak var lblEmptyScreenDescription: UILabel!
    @IBOutlet weak var btnEmptyScreen: LoadingButton!
    
    var type: EmptyScreenType = EmptyScreenType.favourites
    var delegate: EmptyScreenControllerDelegate?
    var isPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        switch type {
        case .favourites:
            setupFavourites()
            break
        case .signToAddToFavourites:
            setupSignToAddToFavourites()
            break
        case .cart:
            setupCart()
            break
        case .search:
            setupSearch()
            break
        case .products:
            setupProducts()
        case .orders:
            setupOrders()
            break
        case .addresses:
            setupAddresses()
            break
        case .area:
            setupArea()
            break
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
        isPresented = true
        DispatchQueue.main.async {
            self.view.frame = CGRect(x: 0, y: UIDevice.isPhone ? 120 : 120, width: view.frame.size.width, height: view.height)
            view.addSubview(self.view)
        }
    }
    
    func close() {
        isPresented = false
        DispatchQueue.main.async {
            self.view.removeFromSuperview()
        }
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
    
    func setupSignToAddToFavourites() {
        setup("you_are_not_login", "add_to_favourite_message", "favouritesPlaceholder", true, nil)
    }
    
    func setupCart() {
        setup("empty_cart_title", "empty_cart_description", "cartPlaceholder", false, "shopping_now")
    }
    
    func setupSearch() {
        setup("empty_search_title", "empty_search_description", "searchPlaceholder", true, nil)
    }
    
    func setupProducts() {
        setup("empty_products_title", "empty_products_description", "emptyPlaceholder", true, nil)
    }
    
    func setupOrders() {
        setup("empty_orders_title", "empty_orders_description", "ordersPlaceholder", true, nil)
    }
    
    func setupAddresses() {
        setup("empty_addresses_title", "empty_addresses_description", "addressesPlaceholder", true, nil)
    }
    
    func setupArea() {
        setup("empty_area_title", "empty_area_description", "emptyPlaceholder", true, nil)
    }
}
