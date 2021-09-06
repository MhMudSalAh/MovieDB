//
//  FooterCollection.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class FooterCollection: UICollectionReusableView {
    
    @IBOutlet weak var refreshControlIndicator: UIActivityIndicatorView!
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
        refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: scaleFactor, y: scaleFactor)
    }
    
    //reset the animation
    func prepareInitialAnimation() {
        isAnimatingFinal = false
        refreshControlIndicator?.stopAnimating()
        //.refreshControlIndicator?.transform = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
    }
    
    func startAnimate() {
        view.isHidden = true
        isAnimatingFinal = true
        refreshControlIndicator?.startAnimating()
    }
    
    func stopAnimate() {
        isAnimatingFinal = false
        refreshControlIndicator?.stopAnimating()
        view.isHidden = false
    }
    
    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.refreshControlIndicator?.transform = CGAffineTransform.identity
        }
    }
}
