//
//  TopRated+Pagination.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

extension TopRatedController {
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshTable(scrollView)
        setupPagination(scrollView)
    }
    
    func refreshTable(_ scrollView: UIScrollView) {
        if refreshTable.isRefreshing && scrollView.contentOffset.y < 0 {
            presenter.getTopRated(1)
        } else {
            endRefresherTable()
        }
    }

    func setupPagination(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.size.height >= tableView.contentSize.height {
            if page.current < page.last {
                page.current += 1
                BeginActivityIndicator(position: CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44)), style: .gray)
                tableView.tableFooterView = activityIndicator
                tableView.tableFooterView?.isHidden = false
                presenter.getTopRated(page.current)
            }
        }
    }
}

