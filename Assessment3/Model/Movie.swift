//
//  Movie.swift
//  Assessment3
//
//  Created by Drew Seeholzer on 6/28/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title
        case imageURL = "poster_path"
        case overview
    }
    
    let rating: Double
    let title: String
    let imageURL: URL
    let overview: String
}

struct TopLevelDictionary: Decodable {
    
    let results: [Movie]
}
