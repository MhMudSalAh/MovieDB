//
//  RangeSliderTrackLayer.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition =  CGFloat(slider.positionForValue(value: slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            ctx.fill(rect)
        }
    }
}

//class RangeSliderTrackLayer: CALayer {
//
//    weak var rangeSlider: RangeSlider?
//
//    override func draw(in ctx: CGContext) {
//        guard let slider = rangeSlider else {
//            return
//        }
//        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        ctx.addPath(path.cgPath)
//        ctx.setFillColor(slider.trackTintColor.cgColor)
//        ctx.fillPath()
//        ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
//        let lowerValuePosition = slider.positionForValue(slider.lowerValue)
//        let upperValuePosition = slider.positionForValue(slider.upperValue)
//        let rect = CGRect(x: lowerValuePosition, y: 0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
//        ctx.fill(rect)
//    }
//}
