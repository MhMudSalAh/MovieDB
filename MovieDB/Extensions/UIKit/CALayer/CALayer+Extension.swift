//
//  CALayer+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import QuartzCore
import UIKit

extension CALayer {
    
    func shadow(color: UIColor = .black, opacity: Float = 1.0, radius: CGFloat = 1.0, offset: CGSize = .zero) {
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        self.shadowOffset = offset
    }
    
    func roundedCorner(radius: CGFloat? = nil) {
        var cornerRadius = CGFloat(roundf(Float(self.frame.size.width / 2.0)))
        if let r = radius {
            cornerRadius = r
        }
        
        self.masksToBounds = true
        self.cornerRadius = cornerRadius
    }
    
    func border(color: UIColor = .black, width: CGFloat) {
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
    
    func addShadowLayer(name: String, shapeLayer: CAShapeLayer, radius: CGFloat, color: UIColor) -> CALayer {
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOffset = CGSize.zero
        shadowLayer.shadowRadius = radius
        shadowLayer.shadowOpacity = 0.6 // increase shadow value to show shadow to nav bar
        shadowLayer.backgroundColor = UIColor.clear.cgColor
        shadowLayer.insertSublayer(shapeLayer, at: 0)
        shadowLayer.name = name
        return shadowLayer
    }
}

extension UIBezierPath {
    
    func topCurvePath(width: CGFloat, y1: CGFloat, y2: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: y1))
        path.addCurve(to: CGPoint(x: width / 2 , y: y2), controlPoint1: CGPoint(x: 0, y: y1), controlPoint2: CGPoint(x:width / 4, y: y2))
        path.addCurve(to: CGPoint(x: width, y: y1), controlPoint1: CGPoint(x: width * 0.75, y: y2), controlPoint2: CGPoint(x: width, y: y1))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x:0, y: 0))
        path.addLine(to: CGPoint(x:0, y: y1))
        path.stroke()
        return path
    }
}
