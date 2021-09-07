//
//  ImageSlider+Collection.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

extension ImageSlider: UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func initCollection() {
        collectionView.initialize(cellClass: SliderCell.self, delegate: self, dataSource: self)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "SliderCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellClass: SliderCell.self, indexPath: indexPath)
        let model = images[indexPath.row]
        cell.setupCell(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.getCurrentIndexPath() {
            currentIndex = indexPath.row
            guard let cell = collectionView.cellForItem(at: indexPath) as? SliderCell else { return }
            if scrollView.contentOffset.y >= 0 {
                cell.didScrollUp(scrollView.contentOffset.y / 2)
            } else {
                cell.didScrollDown(scrollView.contentOffset.y)
            }
        }
    }
}
