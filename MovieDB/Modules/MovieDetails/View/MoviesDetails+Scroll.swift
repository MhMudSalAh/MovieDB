//
//  MoviesDetails+Scroll.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit

extension MovieDetailsController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as? ImageSlider {
            cell.scrollViewDidScroll(scrollView)
        }
    }
}

