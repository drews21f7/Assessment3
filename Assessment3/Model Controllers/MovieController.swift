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
    
    static func fetchMovieFor(query: String, completion: @escaping ([Movie]?) -> Void) {
        guard let url = baseURL else {completion(nil); return}
        
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
    
    static func fetchImageFor(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w92")
        
        guard var url = baseImageURL else {completion(nil); return}
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        //let imageURL = movie.image
        
        url.appendPathComponent(movie.image)
        
        guard let finalURL = components?.url else {completion(nil); return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print ("Error fetching image data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Image data doesn't equal data")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
