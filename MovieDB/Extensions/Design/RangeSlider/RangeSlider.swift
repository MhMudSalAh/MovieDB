//
//  RangeSlider.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
    
    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.2
    var upperValue = 0.8
    
    let trackLayer = RangeSliderTrackLayer()//= CALayer() defined in RangeSliderTrackLayer.swift
    let lowerThumbLayer = RangeSliderThumbLayer()//CALayer()
    let upperThumbLayer = RangeSliderThumbLayer()//CALayer()
    
    let lowerThumbImageView = UIImageView()
    let upperThumbImageView = UIImageView()
    
    var previousLocation = CGPoint()
    
    var trackTintColor = UIColor.init(red: 243, green: 239, blue: 239, a: 1)
    var trackHighlightTintColor = UIColor.primary
    var thumbTintColor = UIColor.primary
    
    var curvaceousness : CGFloat = 1.0
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    var thumbImage = UIImage(named: "circle2") {
        didSet {
            upperThumbImageView.image = thumbImage
            lowerThumbImageView.image = thumbImage
            updateLayerFrames()
        }
    }

    var highlightedThumbImage = UIImage(named: "circle2") {
        didSet {
            upperThumbImageView.highlightedImage = highlightedThumbImage
            lowerThumbImageView.highlightedImage = highlightedThumbImage
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 10)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(value: lowerValue))
        
        lowerThumbImageView.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: -thumbWidth,
                                       width: 30, height: 30)
        lowerThumbImageView.backgroundColor = .white
        lowerThumbImageView.layer.cornerRadius = 15
        lowerThumbImageView.layer.borderColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.4).cgColor
        lowerThumbImageView.layer.border(width: 0.05)
        lowerThumbImageView.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(value: upperValue))
        upperThumbImageView.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: -thumbWidth,
                                       width: 30, height: 30)
        upperThumbImageView.backgroundColor = .white
        upperThumbImageView.layer.cornerRadius = 15
        upperThumbImageView.layer.borderColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.4).cgColor
        upperThumbImageView.layer.border(width: 0.05)
        upperThumbImageView.setNeedsDisplay()
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - 30) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        // Hit test the thumb layers
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        // 2. Update the values
        if lowerThumbImageView.isHighlighted == true {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue-0.05)
        } else if upperThumbImageView.isHighlighted == true {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue+0.05, upperValue: maximumValue)
        }
        
        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        sendActions(for: .valueChanged)
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
}

class RangeSliderThumbLayer: CALayer {
    var highlighted = false
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
            ctx.setShadow(offset: CGSize(width: 1, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
            ctx.setFillColor(slider.thumbTintColor.cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
            
            // Outline
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.setLineWidth(0)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()
            
            if !highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(thumbPath.cgPath)
                ctx.fillPath()
            }
        }
    }
}


//class RangeSlider: UIControl {
//
//    private let lowerThumbImageView = UIImageView()
//    private let upperThumbImageView = UIImageView()
//    private var previousLocation = CGPoint()
//    private let trackLayer = RangeSliderTrackLayer()
//
//    var minimumValue: CGFloat = 0 {
//        didSet { updateLayerFrames() }
//    }
//
//    var maximumValue: CGFloat = 1 {
//        didSet { updateLayerFrames() }
//    }
//
//    var lowerValue: CGFloat = 0.2 {
//        didSet { updateLayerFrames() }
//    }
//
//    var upperValue: CGFloat = 0.8 {
//        didSet { updateLayerFrames() }
//    }
//
//    var trackTintColor = UIColor.init(red: 243, green: 239, blue: 239, a: 1) {
//        didSet { trackLayer.setNeedsDisplay() }
//    }
//
//    var trackHighlightTintColor = UIColor.primary {
//        didSet { trackLayer.setNeedsDisplay() }
//    }
//
//    override var frame: CGRect {
//        didSet { updateLayerFrames() }
//    }
//
//    var thumbImage = UIImage(named: "circle") {
//        didSet {
//            upperThumbImageView.image = thumbImage
//            lowerThumbImageView.image = thumbImage
//            updateLayerFrames()
//        }
//    }
//
//    var highlightedThumbImage = UIImage(named: "circle") {
//        didSet {
//            upperThumbImageView.highlightedImage = highlightedThumbImage
//            lowerThumbImageView.highlightedImage = highlightedThumbImage
//            updateLayerFrames()
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        trackLayer.rangeSlider = self
//        trackLayer.contentsScale = UIScreen.main.scale
//        trackLayer.cornerRadius = 4
//        layer.addSublayer(trackLayer)
//
//        lowerThumbImageView.image = thumbImage
//        addSubview(lowerThumbImageView)
//
//        upperThumbImageView.image = thumbImage
//        addSubview(upperThumbImageView)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func updateLayerFrames() {
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//
//        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 10)
//        trackLayer.setNeedsDisplay()
//        lowerThumbImageView.frame = CGRect(origin: thumbOriginForLowerValue(lowerValue), size: thumbImage!.size)
//        lowerThumbImageView.setNeedsDisplay()
//        lowerThumbImageView.setNeedsLayout()
//        upperThumbImageView.frame = CGRect(origin: thumbOriginForUpperValue(upperValue), size: thumbImage!.size)
//        upperThumbImageView.setNeedsDisplay()
//        upperThumbImageView.setNeedsLayout()
//
//        CATransaction.commit()
//    }
//
//    func positionForValue(_ value: CGFloat) -> CGFloat {
//      return Double(bounds.width - 30) * (value - minimumValue) / (maximumValue - minimumValue) + Double(CGFloat(bounds.height) / 2.0)

//    }
//
//    private func thumbOriginForLowerValue(_ value: CGFloat) -> CGPoint {
//      let x = positionForValue(value) - thumbImage!.size.width / 6
//      return CGPoint(x: x, y: (bounds.height - thumbImage!.size.height) / 2.0)
//    }
//
//    private func thumbOriginForUpperValue(_ value: CGFloat) -> CGPoint {
//        let x = positionForValue(value) - (thumbImage!.size.width - 1.5)
//      return CGPoint(x: x, y: (bounds.height - thumbImage!.size.height) / 2.0)
//    }
//
//}
//
//extension RangeSlider {
//
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        previousLocation = touch.location(in: self)
//
//        if lowerThumbImageView.frame.contains(previousLocation) {
//            lowerThumbImageView.isHighlighted = true
//        } else if upperThumbImageView.frame.contains(previousLocation) {
//            upperThumbImageView.isHighlighted = true
//        }
//
//        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
//    }
//
//    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let location = touch.location(in: self)
//        let deltaLocation = location.x - previousLocation.x
//        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
//
//        previousLocation = location
//
//        if lowerThumbImageView.isHighlighted {
//            lowerValue += deltaValue
//            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue/*-0.1*/)
//
//        } else if upperThumbImageView.isHighlighted {
//            upperValue += deltaValue
//            upperValue = boundValue(upperValue, toLowerValue: lowerValue/*+0.1*/, upperValue: maximumValue)
//        }
//
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        updateLayerFrames()
//        CATransaction.commit()
//        sendActions(for: .valueChanged)
//        return true
//    }
//
//    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
//        return min(max(value, lowerValue), upperValue)
//    }
//
//    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
//        lowerThumbImageView.isHighlighted = false
//        upperThumbImageView.isHighlighted = false
//    }
//}
