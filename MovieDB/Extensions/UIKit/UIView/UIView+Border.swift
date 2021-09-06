//
//  UIView+Border.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UIView {
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

extension UIView {

    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, width: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: width, height: frame.height)
            break
        case .Right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: width, height: frame.height)
            break
        case .Top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: width)
            break
        case .Bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: width)
            break
        }
        layer.addSublayer(border)
    }
}
