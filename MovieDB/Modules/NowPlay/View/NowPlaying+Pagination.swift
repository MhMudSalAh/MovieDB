//
//  NowPlaying+Pagination.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import SkeletonView

extension NowPlayController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshCollection(scrollView)
        setupPagination(scrollView)
    }
        
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return "FooterCollection"
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueFooter(cellClass: FooterCollection.self, indexPath: indexPath)
            self.footer = footer
            self.footer?.backgroundColor = UIColor.clear
            return footer
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if page.current < page.last {
            return CGSize(width: collectionView.bounds.size.width, height: 25)
        } else {
            return CGSize.zero
        }
    }
    
    func refreshCollection(_ scrollView: UIScrollView) {
        if refreshCollection.isRefreshing && scrollView.contentOffset.y < 0 {
            presenter.getNowPlaying(1)
        } else {
            endRefresherCollection()
        }
    }
    
    func setupPagination(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            if page.current < page.last {
                page.current += 1
                DispatchQueue.main.async {
                    self.footer?.startAnimate()
                }
                presenter.getNowPlaying(page.current)
            }
        }
    }
}
