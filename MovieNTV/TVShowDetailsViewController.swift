//
//  TVShowDetailsViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 20/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class TVShowDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var posterImageView: UIImageView!

    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var countAverageLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var numberOfSeasons: UILabel!
    @IBOutlet weak var numberOfEpisodes: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var tv: TV!
    var tvDetails: TV? {
        didSet {
            updateViewsFromData()
        }
    }
    
    var indicator: UIActivityIndicatorView!
    var overlayView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeEmptyText()
        
        getTVDetails()
    }
    
    func getTVDetails() {
        addOverlay()
        DataServices.shared.getTVDetails(tvId: tv.id) { (success, tv) in
            if success {
                self.tvDetails = tv
            }
            self.removeOverlay()
        }
    }
    
    func initializeEmptyText() {
        titleLabel.text = "--"
        genresLabel.text = "--"
        languageLabel.text = "--"
        createdByLabel.text = "--"
        numberOfSeasons.text = "--"
        numberOfEpisodes.text = "--"
        runTimeLabel.text = "--"
        popularityLabel.text = "☆ --"
        countAverageLabel.text = "♡ --"
        countLabel.text = "웃 --"
        overviewLabel.text = "--"
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
    
    func updateViewsFromData() {
        if let posterImagePath = tvDetails?.posterPath {
            DataServices.shared.getImage(posterPath: posterImagePath, with: { (success, image) in
                if success {
                    self.posterImageView.image = image
                }
            })
        }
        
        if let popularity = tvDetails?.popularity {
            let popularityStr = String(format: "%.1f", popularity)
            popularityLabel.text = "☆ \(popularityStr)"
        }
        
        if let countAverage = tvDetails?.voteAverage {
            let countAverageStr = String(format: "%.1f", countAverage)
            countAverageLabel.text = "♡ \(countAverageStr)"
        }
        
        if let count = tvDetails?.voteCount {
            countLabel.text = "웃 \(count)"
        }
        
        if let originalName = tvDetails?.originalName {
            self.titleLabel.text = originalName
        }
        
        if let genres = tvDetails?.genres {
            if genres.count > 0 {
                self.genresLabel.text = ""
                for genre in genres {
                    self.genresLabel.text?.append(genre)
                }
            }
        }
        
        if let language = tvDetails?.originalLanguage {
            self.languageLabel.text = language
        }
        
        if let noOfSeasons = tvDetails?.noOfSeasons {
            self.numberOfSeasons.text = "\(noOfSeasons)"
        }
        
        if let noOfEpisodes = tvDetails?.noOfEpisodes {
            self.numberOfEpisodes.text = "\(noOfEpisodes)"
        }
        
        if let runTimes = tvDetails?.episodeRunTime {
            if runTimes.count > 0 {
                self.runTimeLabel.text = ""
                for (i,runtime) in runTimes.enumerated() {
                    if i != runTimes.count - 1 {
                        self.runTimeLabel.text?.append("\(runtime), ")
                    } else {
                        self.runTimeLabel.text?.append("\(runtime)")
                    }
                }
            }
        }
        
        if let overview = tvDetails?.overview {
            self.overviewLabel.text = overview
        }
        
        if let createdBy = tvDetails?.createdBys {
            if createdBy.count > 0 {
                createdByLabel.text = ""
                for (i, createdByStr) in createdBy.enumerated() {
                    if i != createdBy.count - 1 {
                        createdByLabel.text?.append("\(createdByStr), ")
                    } else {
                        createdByLabel.text?.append(createdByStr)
                    }
                    
                }
            }
        }
        
        
    }
}
