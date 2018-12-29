//
//  MovieDetailsCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieDetailsCoordinator: BaseCoordinator {
    
    private let presenter: UINavigationController
    private var movieDetailsVC: MovieDetailsVC!
    private var movieDetailsVM: MovieDetailsPresentable!
    private let dataServices: DataServices = DataServices.shared
    private let movie: Movie
    
    init(presenter: UINavigationController, movie: Movie) {
        self.presenter = presenter
        self.movie = movie
    }
    
    func start() {
        self.movieDetailsVM = MovieDetailsViewModel()
        self.movieDetailsVM.dataServices = dataServices
        self.movieDetailsVM.movieId = movie.id
        
        self.movieDetailsVC = MovieDetailsVC()
        self.movieDetailsVC.movieDetailsVM = self.movieDetailsVM
        
        self.presenter.present(movieDetailsVC, animated: true)
    }
}
