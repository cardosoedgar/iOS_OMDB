//
//  DetailController.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/5/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    let helperMethods = HelperMethods()
    
    var movie: Movie!
    
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func loadUI() {
        movieTitle.text = "\(movie.title) (\(movie.year))"
        subtitle.text = "\(movie.runtime), \(movie.genre))"
        language.text = "\(movie.language) (\(movie.country))"
        director.text = movie.director
        rating.text = "\(movie.rating) / \(movie.metascore)"
        votes.text = "\(movie.votes) votes"
        plot.text = movie.plot
        actors.text = movie.actors
        
        poster.image = helperMethods.getImage(movie.id)
    }
}
