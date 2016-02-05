//
//  Search.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/5/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import Foundation

class Search {
    
    var movieList: [MovieSearch]?
    var totalResults: Int!
    var currentPage = 1
    var query: String!
    
    init() {
        movieList = [MovieSearch]()
    }
    
    class func movieListFromJson(json: AnyObject?) -> [MovieSearch]? {
        guard json != nil else {
            return nil
        }
        
        if let movieList = json!["Search"] as? NSArray {
            return MovieSearch.parseMovies(movieList)
        }
        
        return nil
    }
    
    class func totalResultsFromJson(json: AnyObject?) -> Int {
        guard json != nil else {
            return 0
        }
        
        if let totalResults = json!["totalResults"] as? String {
            return Int(totalResults)!
        }
        
        return 0
    }
}