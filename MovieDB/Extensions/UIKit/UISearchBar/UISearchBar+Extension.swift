//
//  UISearchBar+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UISearchBar {
    
    @IBInspectable var background: UIImage? {
        get {
            return backgroundImage
        }
        set {
            if newValue == nil {
                backgroundImage = UIImage()
            } else {
                backgroundImage = newValue
            }
        }
    }
}
