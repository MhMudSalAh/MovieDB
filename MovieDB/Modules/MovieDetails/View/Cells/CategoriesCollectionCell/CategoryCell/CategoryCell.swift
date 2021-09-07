//
//  CategoryCell.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    func setupCell(_ category: Category) {
        lblName.text = category.title
    }
}
