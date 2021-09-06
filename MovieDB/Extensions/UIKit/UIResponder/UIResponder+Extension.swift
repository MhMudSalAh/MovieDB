//
//  UIResponder+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UIResponder {
    private weak static var _currentFirstResponder: UIResponder? = nil
    
    public class func currentFirstResponder() -> UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }
    
    @objc internal func findFirstResponder(_ sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
}
