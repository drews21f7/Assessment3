//
//  MovieTableViewController.swift
//  Assessment3
//
//  Created by Drew Seeholzer on 6/28/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieController.fetchMovieFor(query: "Shrek") { (moviesFromCompletion) in
            if let unwrappedMovieItems = moviesFromCompletion {
                self.movies = unwrappedMovieItems
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        //self.tableView.reloadData()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell() }
        
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.ratingLabel.text = "\(movie.rating)"
        cell.overviewTextView.text = movie.overview
        
        MovieController.fetchImageFor(movie: movie) { (image) in
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }

        // Configure the cell...

        return cell
    }
}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text, searchQuery != "" else { return }
        
        MovieController.fetchMovieFor(query: searchQuery) { (moviesFromCompletion) in
            if let unwrappedMovies = moviesFromCompletion {
                self.movies = unwrappedMovies
                //print (self.movies)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
