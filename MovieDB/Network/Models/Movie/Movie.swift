//
//  Movie.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import Foundation

class Movie: NSObject, Codable {

    var id: Int = 0
    var title: String? = ""
    var desc: String? = ""
    var cover: String? = ""
    var image: String? = ""
    var rate: Double? = 0
    var rateCount: Int? = 0
    var date: String? = ""
    var categories: [Category]? = []
        
    override init() {
        super.init()
    }
        
    func coverURL() -> String? {
        if let cover = cover { return API.getImagePath(cover) }
        return nil
    }
    
    func imageURL() -> String? {
        if let image = image { return API.getImagePath(image) }
        return nil
    }
    
    func getImages() -> [String] {
        var images = [String]()
        if let image = imageURL() {
            images.append(image)
        }
        if let cover = coverURL() {
            images.append(cover)
        }
        return images
    }
}

extension Movie {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title
        case desc = "overview"
        case cover = "backdrop_path"
        case image = "poster_path"
        case rate = "vote_average"
        case rateCount = "vote_count"
        case date = "release_date"
        case categories = "genres"
    }
}


