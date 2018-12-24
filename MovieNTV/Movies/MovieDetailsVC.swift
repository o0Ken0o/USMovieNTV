//
//  MovieDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController, HasCustomView {
    
    typealias CustomView = MovieDetailsView
    
    var dataServices: DataServices!
    var movieId: Int!
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        dataServices.getMovieDetails(movieID: movieId) { [unowned self] (success, movie) in
            if success, let movie = movie {
                self.customView.displayWith(movie: movie)
                
                if let posterPath = movie.posterPath {
                    self.dataServices.getImage(posterPath: posterPath, with: { [unowned self] (success, image) in
                        if success {
                            self.customView.showPoster(image: image)
                        }
                    })
                }
            }
        }
    }
}

extension MovieDetailsVC: MovieDetailsViewDelegate {
    func didTapCloseBtn() {
        self.dismiss(animated: true)
    }
}
