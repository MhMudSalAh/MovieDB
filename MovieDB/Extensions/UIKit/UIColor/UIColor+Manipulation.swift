//
//  UIColor+Manipulation.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UIColor {
    
    func brightness(_ percent: CGFloat, lighter: Bool) -> UIColor {
        let v = self.hsba
        var newBrightness = max(v.b * percent, 0.0)
        if lighter {
            newBrightness = min(v.b * percent, 1.0)
        }
        return UIColor(hue: v.h, saturation: v.s, brightness: newBrightness, alpha: v.a)
    }
    
    func lighterColor(percent: CGFloat = 1.25) -> UIColor {
        return self.brightness(percent, lighter: true)
    }
    
    func darkerColor(percent: CGFloat = 0.75) -> UIColor {
        return self.brightness(percent, lighter: false)
    }
    
    public var isDarkColor: Bool {
        return self.lumens < 0.5
    }
    
    public var isBlackOrWhite: Bool {
        let v = self.rgba
        
        if v.r > 0.91 && v.g > 0.91 && v.b > 0.91 {
            return true
        }
        
        if v.r < 0.09 && v.g < 0.09 && v.b < 0.09 {
            return true
        }
        
        return false
    }
    
    public func set(alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    public func set(hue: CGFloat) -> UIColor {
        let v = self.hsba
        
        return UIColor(hue: hue, saturation: v.s, brightness: v.b, alpha: v.a)
    }
    
    public func set(saturation: CGFloat) -> UIColor {
        let v = self.hsba
        
        return UIColor(hue: v.h, saturation: saturation, brightness: v.b, alpha: v.a)
    }
    
    public func set(brightness: CGFloat) -> UIColor {
        let v = self.hsba
        return UIColor(hue: v.h, saturation: v.s, brightness: brightness, alpha: v.a)
    }
    
    public func isDistinct(color: UIColor, threshold: CGFloat = 0.25) -> Bool {
        let rgba1 = self.rgba
        let rgba2 = color.rgba
        
        if  abs(rgba1.r - rgba2.r) > threshold ||
            abs(rgba1.g - rgba2.g) > threshold ||
            abs(rgba1.b - rgba2.b) > threshold ||
            abs(rgba1.a - rgba2.a) > threshold {
            if  abs(rgba1.r - rgba1.g) < 0.03 &&
                abs(rgba1.r - rgba1.b) < 0.03 &&
                abs(rgba2.r - rgba2.g) < 0.03 &&
                abs(rgba2.r - rgba2.b) < 0.03 {
                return false
            }
            return true
        }
        return false
    }
    
    public func isContrasting(color: UIColor) -> Bool {
        let bLum = self.lumens
        let fLum = color.lumens
        
        var contrast: CGFloat = 0.0
        
        if bLum > fLum {
            contrast = (bLum + 0.05) / (fLum + 0.05)
        }
        else {
            contrast = (fLum + 0.05) / (bLum + 0.05)
        }
        return contrast > 1.6
    }
}
