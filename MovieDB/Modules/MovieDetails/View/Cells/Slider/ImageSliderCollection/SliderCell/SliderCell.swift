//
//  SliderCell.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgSlider: UIImageView!
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    
    func setupCell(_ imageUrl: String) {
        imgSlider.loadImage(imageUrl)
    }
    
    func didScrollUp(_ value: CGFloat) {
        viewContainer.clipsToBounds = true
        bottomSpaceConstraint?.constant = -value
        topSpaceConstraint?.constant = value
    }
    
    func didScrollDown(_ value: CGFloat) {
        topSpaceConstraint?.constant = value
        viewContainer.clipsToBounds = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
