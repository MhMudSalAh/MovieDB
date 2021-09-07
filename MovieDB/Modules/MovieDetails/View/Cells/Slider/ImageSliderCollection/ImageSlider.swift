//
//  ImageSlider.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 06/09/2021.
//

import UIKit
import SkeletonView

class ImageSlider: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var lblImagesNum: UILabel!
    @IBOutlet weak var viewBottomCorner: UIView!
    
    let currentPage = UIImage(named: "pageSelected")
    let unCurrentPage = UIImage(named: "pageUnSelected")
    
    var images: [String] = [] {
        didSet {
            reloadData()
        }
    }
    
    var currentIndex: Int = 0 {
        didSet {
            reloadData()
        }
    }
    
    func setupCell(_ images: [String]) {
        self.images = images
        pageController.numberOfPages = images.count
        collectionView.reloadData()
    }
    
    func reloadData() {
        setupLabelImages()
        setupPageController()
    }
    
    func setupLabelImages() {
        lblImagesNum.text = "\(self.currentIndex + 1)/\(images.count)"
    }
    
    func setupPageController() {
        pageController.currentPage = currentIndex
        (0 ..< pageController.numberOfPages).forEach { (index) in
            let pageIcon = index == currentIndex ? currentPage : unCurrentPage
            if #available(iOS 14.0, *) {
                pageController.pageIndicatorTintColor = .white
                pageController.currentPageIndicatorTintColor = .white
                pageController.setIndicatorImage(pageIcon, forPage: index)
            }
        }
    }
    
    func setupViewCornersRadius() {
        viewBottomCorner.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCollection()
        setupViewCornersRadius()
    }
}
