//
//  MovieCell.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var viewFav: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star6: UIImageView!
    @IBOutlet weak var star7: UIImageView!
    @IBOutlet weak var star8: UIImageView!
    @IBOutlet weak var star9: UIImageView!
    @IBOutlet weak var star10: UIImageView!
    
    var delegate: FavoritesDelegate?
    var stars: [UIImageView] = []
    var movie: Movie?
    
    func setupCell(_ movie: Movie, _ delegate: FavoritesDelegate?) {
        self.delegate = delegate
        self.movie = movie
        img.loadImage(movie.imageURL())
        lblTitle.text = movie.title
        lblRate.text = "\(movie.rate?.rounded(places: 1) ?? 0.0)"
        setupRating(movie.rate?.rounded(places: 1) ?? 0.0)
    }
    
    func setupRating(_ rating: Double) {
        var index = 0
        for star in stars {
            star.image = index < Int(rating) ? UIImage(named: "starOn") : UIImage(named: "starOff")
            index += 1
        }
    }
    
    @IBAction func actionFavorite(_ sender: Any) {
        if let movieId = movie?.id {
            delegate?.didClickDeleteFavorite(movieId)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stars = [star1, star2, star3, star4, star5, star6, star7, star8, star9, star10]
    }
}
