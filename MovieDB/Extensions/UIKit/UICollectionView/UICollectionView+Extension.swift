//
//  UICollectionView+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension UICollectionView {
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UICollectionViewCell>(cellClass: Cell.Type, indexPath: IndexPath) -> Cell {
        let identifier = String(describing: cellClass.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerFooterNib<Cell: UICollectionReusableView>(cellClass: Cell.Type) {
        register(UINib(nibName: String(describing: Cell.self), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeueFooter<Cell: UICollectionReusableView>(cellClass: Cell.Type, indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
            fatalError("Error in Footer")
        }
        return cell
    }

    
    func getCurrentIndexPath() -> IndexPath? {
        var visibleRect = CGRect()
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = self.indexPathForItem(at: visiblePoint) else { return nil }
        return indexPath
    }
    
    func initialize<Cell: UICollectionViewCell>(cellClass: Cell.Type, delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource, refreshControl: UIRefreshControl? = nil) {
        self.registerCellNib(cellClass: cellClass)
        self.dataSource = dataSource
        self.delegate = delegate
        self.refreshControl = refreshControl
    }
}

extension UICollectionViewFlowLayout {

    override open var flipsHorizontallyInOppositeLayoutDirection: Bool {

        return LOCAL.getLanguage() == Language.AR.rawValue
    }
}
