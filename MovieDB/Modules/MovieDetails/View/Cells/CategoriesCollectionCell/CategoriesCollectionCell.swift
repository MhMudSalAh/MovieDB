//
//  CategoriesCollectionCell.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

class CategoriesCollectionCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constrainHeightCollection: NSLayoutConstraint!
    
    var categories: [Category] = [] {
        didSet {
            reloadCollection()
        }
    }
    
    func setupCell(_ categories: [Category]) {
        self.categories = categories
        reloadCollection()
    }
    
    func reloadCollection() {
        DispatchQueue.main.async { [self] in
            collectionView.reloadData()
            drawView()
        }
    }
    
    func drawView() {
        if constrainHeightCollection.constant == 50 {
            constrainHeightCollection.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
            collectionView.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    func setuplblTitle() {
        lblTitle.text = localizedText("categories")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollection()
        setuplblTitle()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
