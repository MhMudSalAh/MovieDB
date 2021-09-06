//
//  UIDevice+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UIDevice {
    
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
