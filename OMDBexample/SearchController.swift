//
//  SearchController.swift
//  OMDBexample
//
//  Created by Edgar Cardoso on 2/4/16.
//  Copyright © 2016 Edgar Cardoso. All rights reserved.
//
import UIKit
import Alamofire

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var search = Search()
    let helperMethods = HelperMethods()
    var isRefreshing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        searchBar.becomeFirstResponder()
    }
    
    func requestMovies() {
        Alamofire.request(.GET, "http://www.omdbapi.com/?s=\(search.query)&type=movie&page=\(search.currentPage)").responseJSON {
            (response) -> Void in
            
            if let json = response.result.value {
                if let result = Search.movieListFromJson(json) {
                    self.search.movieList?.appendContentsOf(result)
                }
                self.search.totalResults = Search.totalResultsFromJson(json)
                self.tableView.reloadData()
                self.isRefreshing = false
            }
            
            self.search.currentPage++
        }
    }
    
    //MARK: Table Delegate + Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieCell
        let movie = search.movieList?[indexPath.row]
        
        cell.movieTitle.text = movie?.title
        cell.movieYear.text = movie?.year
        cell.movieImage.downloadImage(movie?.poster)
        
        cell.backgroundColor = setBackgroundColor(indexPath.row)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let movieCell = cell as! MovieCell
        movieCell.movieImage.image = nil
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
        navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.movieList!.count
    }
    
    //MARK: Search Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let query = searchBar.text {
            if !query.isEmpty {
                search = Search()
                search.query = query
                requestMovies()
            }
        }
    }
    
    //MARK: Scroll Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.bounds.size.height) {
            if !isRefreshing && (search.currentPage-1)*10 < search.totalResults {
                isRefreshing = true
                requestMovies()
            }
        }
    }
}