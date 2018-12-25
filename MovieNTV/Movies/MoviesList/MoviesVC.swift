//
//  MoviesVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SnapKit

protocol MoviesVCDelegate: class {
    func didSelect(movie: Movie)
    func viewIsLoaded()
}

class MoviesVC: UIViewController, HasCustomView {
    
    typealias CustomView = MoviesListView
    
    var dataServices: DataServices!
    weak var delegate: MoviesVCDelegate?
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.viewIsLoaded()
        
        loadNowPlayingMovies()
        loadPopularMovies()
        loadTopRatedMovies()
        loadUpcomingMovies()
    }
    
    private func loadNowPlayingMovies() {
        dataServices.getNowPlaying { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.customView.showNowPlaying(movies: movies)
        }
    }
    
    private func loadPopularMovies() {
        dataServices.getPopular { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.customView.showPopular(movies: movies)
        }
    }
    
    private func loadTopRatedMovies() {
        dataServices.getTopRated { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.customView.showTopRated(movies: movies)
        }
    }
    
    private func loadUpcomingMovies() {
        dataServices.getUpcoming { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.customView.showUpcoming(movies: movies)
        }
    }
}

extension MoviesVC: MoviesListViewDelegate {
    func didSelect(movie: Movie) {
        self.delegate?.didSelect(movie: movie)
    }
}
