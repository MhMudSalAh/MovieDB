//
//  MoviesDetails+TableView.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

extension MovieDetailsController: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func initTableView() {
        tableView.initialize(cellClass: ImageSlider.self, delegate: self, dataSource: self, estimatedRowHeight: 100)
        tableView.registerCellNib(cellClass: MovieContentCell.self)
        tableView.registerCellNib(cellClass: CategoriesCollectionCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.row {
        case 0:
            return "ImageSlider"
        case 1:
            return "MovieContentCell"
        default:
            return "CategoriesCollectionCell"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeue(cellClass: ImageSlider.self)
            cell.hideSkeleton()
            cell.setupCell(movie.getImages())
            return cell
        case 1:
            let cell = tableView.dequeue(cellClass: MovieContentCell.self)
            cell.hideSkeleton()
            cell.setupCell(movie)
            return cell
        default:
            let cell = tableView.dequeue(cellClass: CategoriesCollectionCell.self)
            cell.hideSkeleton()
            cell.setupCell(movie.categories ?? [])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 280
        case 2:
            return 250
        default:
            return UITableView.automaticDimension
        }
    }
}
