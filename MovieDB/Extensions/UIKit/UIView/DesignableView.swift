//
//  DesignableView.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

@IBDesignable public class RoundedView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
    }
}

@IBDesignable class DesignableView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkFrame()
    }
    
    func checkFrame() {
        if let layers = layer.sublayers, let gLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is CAGradientLayer
        }) {
            gLayer.frame = bounds
        }
        
        if let layers = layer.sublayers, let bLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            bLayer.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        }
    }
}

extension UIView {
    
    @IBInspectable var cornerRadiusIphone: CGFloat {
        get { return layer.cornerRadius }
        set {
            if UIDevice.isPhone {
                self.layer.cornerRadius = newValue
            }
        }
    }
    
    @IBInspectable var cornerRadiusIpad: CGFloat {
        get { return layer.cornerRadius }
        set {
            if UIDevice.isPad {
                self.layer.cornerRadius = newValue
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set {
            if newValue >= 0 {
                layer.borderWidth = newValue
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return .clear
            }
        }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var bottomBorder: UIColor {
        get { return getBottomBorderColor() }
        set { bottomBorderLayer.backgroundColor = newValue.cgColor }
    }
    
    @IBInspectable var bottomBorder1Pxl: UIColor {
        get { return getBottomBorderColor() }
        set { bottomBorderLayer1Pxl.backgroundColor = newValue.cgColor }
    }
    
    @IBInspectable var topBorder: UIColor {
        get { return getTopBorderColor() }
        set { topBorderLayer.backgroundColor = newValue.cgColor }
    }
    
    var bottomBorderLayer: BottomLayer {
        if let layers = layer.sublayers, let border = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            return border as! BottomLayer
        } else {
            checkObserver()
            let border = BottomLayer()
            border.superView = self
            border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
            layer.addSublayer(border)
            return border
        }
    }
    
    var bottomBorderLayer1Pxl: BottomLayer {
        if let layers = layer.sublayers, let border = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            return border as! BottomLayer
        } else {
            checkObserver()
            let border = BottomLayer()
            border.superView = self
            border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
            layer.addSublayer(border)
            return border
        }
    }
    
    var topBorderLayer: TopLayer {
        if let layers = layer.sublayers, let border = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is TopLayer
        }) {
            return border as! TopLayer
        } else {
            checkObserver()
            let border = TopLayer()
            border.superView = self
            border.frame = CGRect(x: 0, y: 0 ,width: bounds.width, height: 1)
            layer.addSublayer(border)
            
            return border
        }
    }
    
    func getTopBorderColor() -> UIColor {
        if let color = topBorderLayer.backgroundColor {
            return UIColor(cgColor: color)
        } else {
            return .clear
        }
    }
    
    func getBottomBorderColor() -> UIColor {
        if let color = bottomBorderLayer.backgroundColor {
            return UIColor(cgColor: color)
        } else {
            return .clear
        }
    }
    
    @IBInspectable var startColor: UIColor {
        get { return getColor() }
        set { setColor(newValue, 0) }
    }
    
    @IBInspectable var endColor: UIColor {
        get { return getColor() }
        set { setColor(newValue, 1) }
    }
    
    var gradientLayer: GradientLayer {
        if let layers = layer.sublayers, let gLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is GradientLayer
        }) {
            return gLayer as! GradientLayer
        } else {
            checkObserver()
            let gLayer = GradientLayer()
            gLayer.superView = self
            gLayer.frame = bounds
            layer.insertSublayer(gLayer, at: 0)
            return gLayer
        }
    }
    
    func getColor() -> UIColor {
        if let color = gradientLayer.colors?.last as? UIColor {
            return color
        } else {
            return .clear
        }
    }
    
    func setColor(_ color: UIColor, _ index: Int) {
        gradientLayer.colors![index] = color.cgColor
    }
    
    func checkObserver() {
        addObserver(self, forKeyPath: "bounds", options: .init(rawValue: 0), context: nil)
    }
    
    func updateBounds() {
        if let layers = layer.sublayers, let gLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is CAGradientLayer
        }) {
            gLayer.frame = bounds
        }
        
        if let layers = layer.sublayers, let bLayer = layers.first(where: { (currentLayer) -> Bool in
            return currentLayer is BottomLayer
        }) {
            bLayer.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let view = object as? UIView, view == self, keyPath == "bounds" {
            updateBounds()
        }
    }
}

@IBDesignable extension UIView {
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        set { layer.shadowOffset = newValue }
        get { return layer.shadowOffset }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        set { layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
}

class GradientLayer: CAGradientLayer {
    
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        let clear = UIColor.clear.cgColor
        startPoint = CGPoint(x: 1, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
        locations = [0.05, 0.95]
        colors = [clear, clear]
        isObserving = false
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
            superView.removeObserver(superView, forKeyPath: "bounds")
        }
    }
}

class BottomLayer: CALayer {
    
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        
        isObserving = true
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
            superView.removeObserver(superView, forKeyPath: "bounds")
        }
    }
}

class TopLayer: CALayer {
    
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        
        isObserving = true
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
            superView.removeObserver(superView, forKeyPath: "bounds")
        }
    }
}

class ShadowPath: UIBezierPath {
    var superView: UIView!
    var isObserving = false
    
    override init() {
        super.init()
        isObserving = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if isObserving {
            isObserving = false
        }
    }
}
