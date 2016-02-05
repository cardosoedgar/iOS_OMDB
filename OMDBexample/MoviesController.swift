//
//  ViewController.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import UIKit

class MoviesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let helperMethods = HelperMethods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieCell
        
        cell.movieTitle.text = "Looper"
        cell.movieRating.text = "7.6"
        cell.movieRunTimeGenre.text = "126min, Action"
        cell.movieYear.text = "2012"
//        edgarcell.movieImage.image = helperMethods.getImage("batman.png")
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 0.5)
        }

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

