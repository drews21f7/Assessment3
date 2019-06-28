//
//  MovieController.swift
//  Assessment3
//
//  Created by Drew Seeholzer on 6/28/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class MovieController {
    
    //https://api.themoviedb.org/3/search/movie?api_key=3426acb26cb2a609a0b58991b1295686&query=Jack+Reacher
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    static func fetchMovieFor(key: String, query: String, completion: @escaping ([Movie]?) -> Void) {
        guard var url = baseURL else {completion(nil); return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let keyQuery = URLQueryItem(name: "api_key", value: "3426acb26cb2a609a0b58991b1295686")
        
        let searchQuery = URLQueryItem(name: "query", value: query)
        
        components?.queryItems = [keyQuery, searchQuery]
        
        guard let finalURL = components?.url else {completion(nil); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print ("Error, search didn't work: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {completion(nil); return}
            
            do {
                let decoder = JSONDecoder()
                let topLevelDictionary = try decoder.decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary.results)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }.resume()
    }
}
