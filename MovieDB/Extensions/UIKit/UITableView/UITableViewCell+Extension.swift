//
//  UITableViewCell+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UITableViewCell {
    
    @IBInspectable var disclosureIndicatorColor: UIColor? {
        get {
            let button = getdisclosureIndicatorButton()
            return button?.tintColor
        }
        set {
            let button = getdisclosureIndicatorButton()
            let image = button?.backgroundImage(for: .normal)?.withRenderingMode(.alwaysTemplate)
            button?.setImage(image, for: .normal)
            button?.tintColor = newValue
        }
    }
    
    private func getdisclosureIndicatorButton() -> UIButton? {
        for view in subviews {
            if let button = view as? UIButton {
                return button
            }
        }
        return nil
    }
}
