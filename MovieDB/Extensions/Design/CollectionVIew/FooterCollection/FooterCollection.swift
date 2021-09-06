//
//  FooterCollection.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class FooterCollection: UICollectionReusableView {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var view: UIView!
    
    var isAnimatingFinal:Bool = false
    var currentTransform:CGAffineTransform?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareInitialAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setTransform(inTransform:CGAffineTransform, scaleFactor:CGFloat) {
        if isAnimatingFinal {
            return
        }
        currentTransform = inTransform
        indicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    func prepareInitialAnimation() {
        isAnimatingFinal = false
        indicator?.stopAnimating()
    }
    
    func startAnimate() {
        view.isHidden = true
        isAnimatingFinal = true
        indicator?.startAnimating()
    }
    
    func stopAnimate() {
        isAnimatingFinal = false
        indicator?.stopAnimating()
        view.isHidden = false
    }
    
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.indicator?.transform = CGAffineTransform.identity
        }
    }
}
