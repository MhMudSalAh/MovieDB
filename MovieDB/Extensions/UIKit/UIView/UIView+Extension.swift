//
//  UIView+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UIView {
    
    func addIndicator(_ style: UIActivityIndicatorView.Style) {
        removeIndicator()
        let indicator = UIActivityIndicatorView(style: style)
        var frame = indicator.frame
        frame.size = self.frame.size
        indicator.frame = frame
        indicator.tag = 1
        indicator.startAnimating()
        self.addSubview(indicator)
    }
    
    func removeIndicator() {
        for subView in self.subviews {
            if let indicator = subView as? UIActivityIndicatorView, indicator.tag == 1 {
                indicator.removeFromSuperview()
            }
        }
    }
    
    func setShadowAndCorners(isCorners: Bool, isShadow: Bool, radius: Int) {
        if isShadow { setShadow() }
        if isCorners { self.layer.cornerRadius = CGFloat(radius); self.layer.masksToBounds = false }
    }
    
    func setShadow() {
        setShadowFrame(2)
        self.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.10).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func clearShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
        self.layer.masksToBounds = true
    }
    
    func setShadowFrame(_ sSize: CGFloat) {
        let newFrame = CGRect(x: -sSize / 2, y: -sSize / 2, width: frame.size.width + sSize, height: frame.size.height + sSize)
        let sPath = ShadowPath(roundedRect: newFrame, cornerRadius: layer.cornerRadius)
        sPath.superView = self
        layer.shadowPath = sPath.cgPath
    }
    
    func circularView() {
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
}
