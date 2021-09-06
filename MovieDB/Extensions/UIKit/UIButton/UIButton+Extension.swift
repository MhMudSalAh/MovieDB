//
//  UIButton+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UIButton {
    
    @IBInspectable var imageViewContentType: Int {
        get {
            return imageView?.contentMode.rawValue ?? 0
        }
        set {
            if let content = UIView.ContentMode(rawValue: newValue), imageView != nil {
                imageView!.contentMode =  content
            }
        }
    }
    
    @IBInspectable var imageInsestsIphone: CGFloat {
        get { return layer.cornerRadius }
        set {
            if UIDevice.isPhone {
                imageEdgeInsets = UIEdgeInsets(top: newValue, left: newValue, bottom: newValue, right: newValue)
            }
        }
    }
    
    @IBInspectable var imageInsestsIpad: CGFloat {
        get { return layer.cornerRadius }
        set {
            if UIDevice.isPad {
                imageEdgeInsets = UIEdgeInsets(top: newValue, left: newValue, bottom: newValue, right: newValue)
            }
        }
    }
    
    /**
     This method is used to create the default button styple for the application
     
     - parameter color: The color of backgroud and by default it is the primary color
     - parameter titleKey: The key localized to be a title of button with .normal style
     */
    func btnDefault(cornerRadius: CGFloat? = 6, color: UIColor? = .primary, titleKey: String? = nil) {
        self.backgroundColor = color
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        //self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = cornerRadius ?? 6
        if titleKey != nil {
            setTitle(titleKey!)
        }
    }
    
    func btnDefaultWithBorder(cornerRadius: CGFloat? = 6, color: UIColor? = .primary, titleKey: String? = nil) {
        self.layer.borderColor = color!.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
        self.layer.cornerRadius = cornerRadius ?? 6
        if titleKey != nil {
            setTitle(titleKey!)
        }
    }
    
    func shadow() {
        self.backgroundColor = .primary
        self.layer.shadowColor = UIColor(red: 152/255.0 , green: 107/255.0, blue: 72/255.0, alpha: 0.47).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
    }
    
    func underLine(title: String) {
        let attrs = [NSAttributedString.Key.font : self.titleLabel!.font!,
                     NSAttributedString.Key.foregroundColor : self.titleColor(for: .normal)!,
                     NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: "")
        let buttonTitleStr = NSMutableAttributedString(string: title, attributes:attrs)
        attributedString.append(buttonTitleStr)
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    /**
     Addin a localized title to button
     
     - parameter key: The key localized to be a title of button with .normal style
     */
    func setTitle(_ key: String) {
        self.setTitle(localizedText(key), for: .normal)
    }
}
