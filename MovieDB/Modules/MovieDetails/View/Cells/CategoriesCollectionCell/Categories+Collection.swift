//
//  Categories+Collection.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 07/09/2021.
//

import UIKit
import SkeletonView

extension CategoriesCollectionCell: UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func initCollection() {
        collectionView.initialize(cellClass: CategoryCell.self, delegate: self, dataSource: self)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CategoryCell"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: CategoryCell.self, indexPath: indexPath)
        cell.setupCell(categories[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var lblSize = CGSize(width: 0, height: 0)
        if !categories.isEmpty {
            lblSize = categories[indexPath.row].title?.size(withAttributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
            ]) ?? CGSize()
        }  else {
            return lblSize
        }
        return CGSize(width: lblSize.width + 30, height: 40)
    }
}
