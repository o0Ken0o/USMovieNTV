//
//  MovieDetailsViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 18/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieScrollView: UIScrollView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countAverageLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    var movie: Movie!
    
    var movieDetails: Movie? {
        didSet {
            setupMovieDetailsView()
        }
    }
    
    var indicator: UIActivityIndicatorView!
    var overlayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeEmptyText()
        
        setupBasicView()
        
        addOverlay()
        DataServices.shared.getMovieDetails(movieID: movie.id) { (success, movie) in
            if success {
                if let movie = movie {
                    self.movieDetails = movie
                }
            }
            self.removeOverlay()
        }
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
    
    func initializeEmptyText() {
        titleLabel.text = " "
        genresLabel.text = " "
        languagesLabel.text = " "
        companiesLabel.text = " "
        countriesLabel.text = " "
        releaseDateLabel.text = " "
        runtimeLabel.text = " "
        popularityLabel.text = "☆ --"
        countAverageLabel.text = "♡ --"
        countLabel.text = "웃 --"
    }
    
    func setupBasicView() {
        if let posterPath = movie.posterPath {
            DataServices.shared.getImage(posterPath: posterPath, with: { (success, image) in
                if success {
                    self.posterImageView.image = image
                }
            })
        }
        
        titleLabel.text? = movie.title
    }
    
    func setupMovieDetailsView() {
        if let genres = movieDetails?.genres, genres.count > 0 {
            var text = ""
            for (i, genreStr) in genres.enumerated() {
                if i != genres.count - 1 {
                    text.append("\(genreStr), ")
                } else {
                    text.append(genreStr)
                }
            }
            genresLabel.text = text
        } else {
            genresLabel.text? = "--"
        }
        
        if let languages = movieDetails?.spokenLanguages, languages.count > 0 {
            var text = ""
            for (i, languageStr) in languages.enumerated() {
                if i != languages.count - 1 {
                    _ = text.append("\(languageStr), ")
                } else {
                    _ = text.append(languageStr)
                }
            }
            languagesLabel.text = text
        } else {
            languagesLabel.text? = "--"
        }
        
        if let companies = movieDetails?.productionCompanies, companies.count > 0 {
            var text = ""
            for (i, companyStr) in companies.enumerated() {
                if i != companies.count - 1 {
                    _ = text.append("\(companyStr), ")
                } else {
                    _ = text.append(companyStr)
                }
            }
            companiesLabel.text = text
        } else {
            companiesLabel.text? = "--"
        }
        
        if let countries = movieDetails?.productionCountries, countries.count > 0 {
            var text = ""
            for (i, countryStr) in countries.enumerated() {
                if i != countries.count - 1 {
                    _ = text.append("\(countryStr), ")
                } else {
                    _ = text.append(countryStr)
                }
                
            }
            countriesLabel.text = text
        } else {
            countriesLabel.text = "--"
        }
        
        if let releaseDate = movieDetails?.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            releaseDateLabel.text? = dateFormatter.string(from: releaseDate)
        } else {
            releaseDateLabel.text = "--"
        }
        
        if let runtime = movieDetails?.runTimeMins {
            runtimeLabel.text = "\(runtime)"
        } else {
            runtimeLabel.text = "--"
        }
        
        if let popularityFloat = movieDetails?.popularity {
            let popularity = String(format: "%.1f", popularityFloat)
            popularityLabel.text = "☆ \(popularity)"
        } else {
            popularityLabel.text = "☆ --"
        }
        
        if let count = movieDetails?.voteCount {
            countLabel.text = "웃 \(count)"
        } else {
            countLabel.text = "웃 --"
        }
        
        if let countAverage = movieDetails?.voteAverage {
            let countAverageStr = String(format: "%.1f", countAverage)
            countAverageLabel.text = "♡ \(countAverageStr)"
        } else {
            countAverageLabel.text = "♡ --"
        }
    }

}
