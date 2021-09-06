//
//  Base+Refresh.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

extension BaseController {
    
    func addRefresherTable(_ tableView: UITableView, _ color: UIColor? = .primary) {
        tableView.refreshControl = refreshTable
        self.refreshTable.tintColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.refreshTable.beginRefreshing()
        }
    }
    
    func endRefresherTable() {
        if refreshTable.isRefreshing {
            UIView.animate(withDuration: 0.5) {
                self.refreshTable.endRefreshing()
            }
        }
    }
    
    func addRefresherCollection(_ collection: UICollectionView, _ color: UIColor? = .primary) {
        collection.refreshControl = refreshCollection
        refreshCollection.tintColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.refreshCollection.beginRefreshing()
        }
    }
    
    func endRefresherCollection() {
        if refreshCollection.isRefreshing {
            UIView.animate(withDuration: 0.5) {
                self.refreshCollection.endRefreshing()
            }
        }
    }
    
    func BeginActivityIndicator(position: CGRect? = CGRect.init(x: 0, y: 0, width: 50, height: 50), style: UIActivityIndicatorView.Style? = .white, color: UIColor? = .primary) {
        activityIndicator = UIActivityIndicatorView(frame: position!)
        activityIndicator.centerY = view.frame.height/2
        activityIndicator.centerX = view.frame.width/2
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = style!
        activityIndicator.color = color
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
    }
    
    func addIndicatorBackgroud() {
        greyView.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        greyView.backgroundColor = .white
        greyView.alpha = 0.5
        view.isUserInteractionEnabled = false
        view.addSubview(greyView)
    }
    
    func removeIndicatorBackgroud() {
        view.isUserInteractionEnabled = true
        greyView.removeFromSuperview()
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
}
