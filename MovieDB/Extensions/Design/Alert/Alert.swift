//
//  Alert.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

let ALERT = Alert.shared

protocol AlertWithTextFieldDelegate {
    func didClickedAlertDefault(_ text: String)
    func didClickedAlertCancel()
    func alertEmptyTextField()
}

protocol AlertWithThreeButtons {
    func didClickAlertWithThreeButtons(_ btnNo: Int)
}

protocol AlertWithTwoButtons {
    func didClickAlertWithTwoButtons(_ btnNo: Int)
}

protocol AlertWithOneButton {
    func didClickAlertWithOneButton(_ btnNo: Int)
}

class Alert {
    
    static let shared = Alert()
    var alert: UIAlertController = UIAlertController()
    
    func withTextField(vc: UIViewController, title: String? = nil, message: String? = nil, placeholder: String, btnTitle: String, delegate: AlertWithTextFieldDelegate) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields![0]
            
            if let text = textField?.text, !(textField?.text?.isEmpty ?? true) {
                alert?.dismiss(animated: true, completion: nil)
                delegate.didClickedAlertDefault(text)
            } else {
                delegate.alertEmptyTextField()
            }
        }))
        
        alert.addAction(UIAlertAction(title: localizedText("cancel"), style: .cancel, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func withThreeButtons(vc: UIViewController, title: String? = nil, message: String? = nil, btnOneTitle: String, btnTwoTitle: String, btnThreeTitle: String, delegate: AlertWithThreeButtons) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: { action in
            delegate.didClickAlertWithThreeButtons(1)
        }))
        
        alert.addAction(UIAlertAction(title: btnTwoTitle, style: .default, handler: { action in
            delegate.didClickAlertWithThreeButtons(2)
        }))
        
        alert.addAction(UIAlertAction(title: btnThreeTitle, style: .cancel, handler: { action in
            delegate.didClickAlertWithThreeButtons(3)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func withTwoButtons(vc: UIViewController, title: String? = nil, message: String? = nil, btnOneTitle: String, btnTwoTitle: String, delegate: AlertWithTwoButtons) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: { action in
            delegate.didClickAlertWithTwoButtons(1)
        }))
        
        alert.addAction(UIAlertAction(title: btnTwoTitle, style: .default, handler: { action in
            delegate.didClickAlertWithTwoButtons(2)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func withOneButton(vc: UIViewController, title: String? = nil, message: String? = nil, btnOneTitle: String, delegate: AlertWithOneButton) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: { action in
            delegate.didClickAlertWithOneButton(1)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }

}

// MARK: Functions Usage

extension Alert {
    
    func resetPassword(vc: UIViewController, delegate: AlertWithTextFieldDelegate) {
        ALERT.withTextField(vc: vc, title: localizedText("reset_password"), message: localizedText("reset_password_message"), placeholder: localizedText("email"), btnTitle: localizedText("send"), delegate: delegate)
    }
    
    func atToFavourite(vc: UIViewController, delegate: AlertWithThreeButtons) {
        ALERT.withThreeButtons(vc: vc, title: localizedText("you_are_not_login"), message: localizedText("add_to_favourite_message"), btnOneTitle: localizedText("sign_in"), btnTwoTitle: localizedText("sign_up"), btnThreeTitle: localizedText("cancel"), delegate: delegate)
    }
    
    func cartRemoveAll(vc: UIViewController, delegate: AlertWithTwoButtons) {
        ALERT.withTwoButtons(vc: vc, title: localizedText("remove_all"), message: localizedText("cart_remove_all_message"), btnOneTitle: localizedText("yes"), btnTwoTitle: localizedText("cancel"), delegate: delegate)
    }
    
    func deleteAddress(vc: UIViewController, delegate: AlertWithTwoButtons) {
        ALERT.withTwoButtons(vc: vc, title: localizedText("delete_address"), message: localizedText("address_delete_message"), btnOneTitle: localizedText("yes"), btnTwoTitle: localizedText("cancel"), delegate: delegate)
    }
    
    func chooseArea(vc: UIViewController, delegate: AlertWithTwoButtons) {
        ALERT.withTwoButtons(vc: vc, title: localizedText("choose_area_message"), message: localizedText("choose_area_request"), btnOneTitle: localizedText("yes"), btnTwoTitle: localizedText("cancel"), delegate: delegate)
    }
    
    func cancelProduct(vc: UIViewController, delegate: AlertWithTwoButtons) {
        ALERT.withTwoButtons(vc: vc, title: localizedText("product_cancel_title"), message: localizedText("product_cancel_message"), btnOneTitle: localizedText("yes"), btnTwoTitle: localizedText("cancel"), delegate: delegate)
    }
    
    func differentArea(vc: UIViewController, delegate: AlertWithOneButton) {
        ALERT.withOneButton(vc: vc, title: localizedText("empty_area_title"), message: localizedText("empty_area_description"), btnOneTitle: localizedText("ok"), delegate: delegate)
    }
    
    func CartDifferentArea(vc: UIViewController, delegate: AlertWithTwoButtons) {
        ALERT.withTwoButtons(vc: vc, title: localizedText("choose_area_message"), message: localizedText("add_product_request"), btnOneTitle: localizedText("yes"), btnTwoTitle: localizedText("cancel"), delegate: delegate)
    }
    
    func emptyQuantities(vc: UIViewController, delegate: AlertWithOneButton) {
        ALERT.withOneButton(vc: vc, title: localizedText("empty_area_title"), message: localizedText("empty_quantities_description"), btnOneTitle: localizedText("ok"), delegate: delegate)
    }
}
