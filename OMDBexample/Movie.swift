//
//  Movie.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//
import CoreData
import Foundation

class Movie: NSManagedObject {
    
    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var year: String
    @NSManaged var rated: String
    @NSManaged var released: String
    @NSManaged var runtime: String
    @NSManaged var genre: String
    @NSManaged var director: String
    @NSManaged var writer: String
    @NSManaged var actors: String
    @NSManaged var plot: String
    @NSManaged var poster: String
    @NSManaged var rating: String
    @NSManaged var country: String
    @NSManaged var language: String
    @NSManaged var metascore: String
    @NSManaged var votes: String
    
    class func initFromJson(json: NSDictionary, andContext context: NSManagedObjectContext) -> Movie {
        let movieEntity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)
        let movie = Movie(entity: movieEntity!, insertIntoManagedObjectContext: context)
        
        movie.id = json["imdbID"] as! String
        movie.title = json["Title"] as! String
        movie.year = json["Year"] as! String
        movie.rated = json["Rated"] as! String
        movie.released = json["Released"] as! String
        movie.runtime = json["Runtime"] as! String
        movie.genre = json["Genre"] as! String
        movie.director = json["Director"] as! String
        movie.writer = json["Writer"] as! String
        movie.actors = json["Actors"] as! String
        movie.plot = json["Plot"] as! String
        movie.poster = json["Poster"] as! String
        movie.rating = json["imdbRating"] as! String
        movie.language = json["Language"] as! String
        movie.country = json["Country"] as! String
        movie.metascore = json["Metascore"] as! String
        movie.votes = json["imdbVotes"] as! String
        
        return movie
    }
}