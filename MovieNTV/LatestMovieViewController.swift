//
//  MovieViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class LastestMovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.layer.cornerRadius = 5
        
        DataServices.shared.getLastest { (success: Bool, movie: Movie?) in
            if success {
                if let movie = movie {
                    print("\(movie): movie")
                    self.titleLabel.text = movie.title
                    self.descriptionTextView.text = (movie.overview == nil || movie.overview == "") ? "no description" : movie.overview
                    if let posterPath = movie.posterPath {
                        DataServices.shared.getImage(posterPath: posterPath, with: { (success: Bool, image: UIImage?) in
                            if success {
                                if let image = image {
                                    self.posterImage.image = image
                                }
                            }
                        })
                    }
                }
            } else {
                // error handling
            }
        }
    }
    
}

