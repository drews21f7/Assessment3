//
//  Movie.swift
//  Assessment3
//
//  Created by Drew Seeholzer on 6/28/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    
    let results: [Movie]
}

struct Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case rating = "vote_average"
        case title
        case image = "poster_path"
        case overview
    }
    
    let rating: Double
    let title: String
    let image: String
    let overview: String
}

