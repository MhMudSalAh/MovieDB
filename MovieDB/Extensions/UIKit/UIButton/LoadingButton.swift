//
//  LoadingButton.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class LoadingButton: UIButton {
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    func showLoading() {
        self.isEnabled = false
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }
        showSpinning()
    }
    
    func hideLoading() {
        if activityIndicator != nil && activityIndicator.isAnimating {
            self.isEnabled = true
            self.setTitle(originalButtonText, for: .normal)
            if activityIndicator.isAnimating {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
