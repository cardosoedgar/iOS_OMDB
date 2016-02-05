//
//  DataProvider.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import CoreData
import Foundation

class CoreDataProvider {
    
    let coreData = CoreDataStackManager()

    func saveMovie(json: NSDictionary?) -> Movie? {
        if json != nil {
            let movie = Movie.initFromJson(json!, andContext: coreData.context)
            coreData.saveContext()
            return movie
        }
        
        return nil
    }
    
    func getMovies() -> [Movie] {
        let movieFetch = NSFetchRequest(entityName: "Movie")
        
        do {
            if let result = try coreData.context.executeFetchRequest(movieFetch) as? [Movie] {
                return result
            }
        } catch {
            return [Movie]()
        }
        
        return [Movie]()
    }
    
    func deleteMovie(movie: Movie) {
        coreData.context.deleteObject(movie)
        coreData.saveContext()
    }
}