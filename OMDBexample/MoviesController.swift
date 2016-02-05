//
//  ViewController.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import UIKit

protocol MovieSelectedDelegate {
    func downloadMovieInfo(id: String)
}

class MoviesController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieSelectedDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let coreDataProvider = CoreDataProvider()
    let helperMethods = HelperMethods()
    var movieList: [Movie]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieList = coreDataProvider.getMovies()
    }
    
    func downloadMovieInfo(id: String) {
        helperMethods.startActivityIndicator()
        let url = "http://www.omdbapi.com/?i=\(id)"
        helperMethods.requestMovie(url) { (json, error) -> Void in
            self.helperMethods.stopActivityIndicator()
            guard error == nil else {
                self.showAlert(error!)
                return
            }
            
            if let movie = self.coreDataProvider.saveMovie(json as? NSDictionary) {
                self.downloadImage(movie)
                self.movieList.append(movie)
                self.tableView.reloadData()
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = self.helperMethods.createAlert(message)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func downloadImage(movie: Movie) {
        helperMethods.downloadImage(movie.poster, completionHandler: { (image) -> Void in
            self.helperMethods.saveImage(image, filename: movie.id)
            self.tableView.reloadData()
        })
    }
    
    //MARK: Table Delegate and Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieCell
        let movie = movieList[indexPath.row]
        
        cell.movieTitle.text = movie.title
        cell.movieRating.text = movie.rating
        cell.movieRunTimeGenre.text = "\(movie.runtime), \(movie.genre)"
        cell.movieYear.text = movie.year
        cell.movieImage.image = helperMethods.getImage(movie.id)
        
        cell.backgroundColor = setBackgroundColor(indexPath.row)

        return cell
    }
    
    func setBackgroundColor(position: Int) -> UIColor {
        if position % 2 == 0 {
            return UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 0.5)
        } else {
            return UIColor.whiteColor()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch(segue.identifier!) {
            case "SearchController":
                let searchController = segue.destinationViewController as! SearchController
                searchController.movieSelectedDelegate = self
                break
            case "DetailController":
                let detailController = segue.destinationViewController as! DetailController
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailController.movie = movieList[indexPath.row]
                }
                break
            default:
                break
        }
    }
}

