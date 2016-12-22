//
//  SearchResultViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 22/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var resultMoviesArray = [Movie]()
    var resultTVsArray = [TV]()
    var isMovie = true
    var currentKeywords: String?
    var searchMovieAlready = false
    var searchTVsShowAlready = false
    
    var indicator: UIActivityIndicatorView!
    var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // added a key View controller-based status bar appearance in info.plist
        UIApplication.shared.statusBarStyle = .lightContent
        
        searchBar.delegate = self
        searchBar.scopeButtonTitles = ["Movies", "TV Shows"]
        
        searchResultTableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isMovie ? resultMoviesArray.count : resultTVsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.posterImageView.image = UIImage(named: "movieNTV")
        cell.firstAirDateLabel.text = "--"
        cell.popularityLabel.text = "☆ --"
        cell.titleLabel.text = "title: --"
        
        if isMovie {
            let movie = resultMoviesArray[indexPath.row]
            if let posterImagePath = movie.posterPath {
                DataServices.shared.getImage(posterPath: posterImagePath, with: { (success, image) in
                    if success, let image = image {
                        cell.posterImageView.image = image
                    }
                })
            }
            
            if let releaseDate = movie.releaseDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                cell.firstAirDateLabel.text = dateFormatter.string(from: releaseDate)
            }
            
            
            let popularityStr = String(format: "%.1f", movie.popularity)
            cell.popularityLabel.text = "☆ \(popularityStr)"
            
            cell.titleLabel.text = movie.originalTitle
        } else {
            let tv = resultTVsArray[indexPath.row]
            if let posterImagePath = tv.posterPath {
                DataServices.shared.getImage(posterPath: posterImagePath, with: { (success, image) in
                    if success, let image = image {
                        cell.posterImageView.image = image
                    }
                })
            }
            
            if let firstAirDate = tv.firstAirDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                cell.firstAirDateLabel.text = dateFormatter.string(from: firstAirDate)
            }
            
            if let popularity = tv.popularity {
                let popularityStr = String(format: "%.1f", popularity)
                cell.popularityLabel.text = "☆ \(popularityStr)"
            }
            
            if let titleStr = tv.originalName {
                cell.titleLabel.text = titleStr
            }
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func addOverlay() {
        overlayView = UIView(frame: self.view.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.center = self.overlayView.center
        indicator.startAnimating()
        overlayView.addSubview(indicator)
        
        if let navVC = self.navigationController {
            navVC.view.addSubview(overlayView)
        } else {
            self.view.addSubview(overlayView)
        }
    }
    
    func removeOverlay() {
        overlayView.removeFromSuperview()
    }
    
    func searchMoviesOrTVs() {
        
        if let keywords = currentKeywords, keywords.characters.count > 0 {
            if isMovie {
                if !searchMovieAlready {
                    searchMovies(keywords)
                } else {
                    searchResultTableView.reloadData()
                }
            } else {
                if !searchTVsShowAlready {
                    searchTVs(keywords)
                } else {
                    searchResultTableView.reloadData()
                }
            }
        }
    }
    
    func searchMovies(_ keywords: String) {
        searchMovieAlready = true
        
        addOverlay()
        DataServices.shared.searchMovies(query: keywords) { (success, movies) in
            if success, let movies = movies {
                self.resultMoviesArray = movies
            }
            self.searchResultTableView.reloadData()
            self.removeOverlay()
        }
    }
    
    func searchTVs(_ keywords: String) {
        searchTVsShowAlready = true
        
        addOverlay()
        DataServices.shared.searchTVShows(query: keywords, with: { (success, tvs) in
            if success, let tvs = tvs {
                self.resultTVsArray = tvs
            }
            self.searchResultTableView.reloadData()
            self.removeOverlay()
        })
        
    }
    
    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        currentKeywords = searchBar.text
        
        searchMovieAlready = false
        searchTVsShowAlready = false
        
        searchMoviesOrTVs()
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        isMovie = (selectedScope == 0)
        searchMoviesOrTVs()
    }
}
