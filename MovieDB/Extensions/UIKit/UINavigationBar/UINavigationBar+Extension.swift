//
//  UINavigationBar+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UINavigationBar {
    
    @IBInspectable var background: UIImage? {
        get {
            return backgroundImage(for: .default)
        }
        set {
            if newValue == nil {
                setBackgroundImage(UIImage(), for: .default)
            } else {
                setBackgroundImage(newValue, for: .default)
            }
            
            shadowImage = UIImage()
        }
    }
}
