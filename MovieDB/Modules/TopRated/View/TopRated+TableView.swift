//
//  TopRated+TableView.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

extension TopRatedController: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func initTableView() {
        tableView.initialize(cellClass: TopRatedCell.self, delegate: self, dataSource: self, estimatedRowHeight: 100, refreshControl: refreshTable)
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topRated.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "TopRatedCell"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: TopRatedCell.self)
        cell.hideSkeleton()
        cell.setupCell(topRated[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
