//
//  MovieSearch.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import Foundation

class MovieSearch {
    
    var id: String
    var title: String
    var year: String
    var poster: String
    
    init(json: NSDictionary) {
        id = json["imdbID"] as! String
        title = json["Title"] as! String
        year = json["Year"] as! String
        poster = json["Poster"] as! String
    }
    
    class func parseMovies(json: NSArray) -> [MovieSearch] {
        var movies = [MovieSearch]()
        for item in json {
            let newMovie = MovieSearch(json: item as! NSDictionary)
            movies.append(newMovie)
        }
        
        return movies
    }
}