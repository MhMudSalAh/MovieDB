//
//  UIImageView+Extension.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(_ urlString: String?) {
        let imagePlaceholder = UIImage(named: "placeholder")
        if let urlString = urlString, let url = URL(string: urlString) {
            self.sd_setImage(with: url, placeholderImage: imagePlaceholder) { (image, error, cacheType, url) -> Void in
                if error != nil {
                    self.image = imagePlaceholder
                }
            }
            return
        }
        self.image = imagePlaceholder
    }
    
    func loadImageProfile(_ urlString: String?) {
        let imagePlaceholder = UIImage(named: "profilePhoto")
        if let urlString = urlString, let url = URL(string: urlString) {
            self.sd_setImage(with: url, placeholderImage: imagePlaceholder) { (image, error, cacheType, url) -> Void in
                if error != nil {
                    self.image = imagePlaceholder
                }
            }
            return
        }
        self.image = imagePlaceholder
    }
    
    func loadImageNative(_ urlString: String?) {
        let imagePlaceholder = UIImage(named: "placeholder")
        if let urlString = urlString {
            NETWORK.loadImage(from: urlString) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async { self.image = image }
            }
        }
        self.image = imagePlaceholder
    }
}
