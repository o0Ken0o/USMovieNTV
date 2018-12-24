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
    private let dataServices: DataServices = DataServices.shared
    private let movie: Movie
    
    init(presenter: UINavigationController, movie: Movie) {
        self.presenter = presenter
        self.movie = movie
    }
    
    func start() {
        self.movieDetailsVC = MovieDetailsVC()
        self.movieDetailsVC.dataServices = dataServices
        self.movieDetailsVC.displayWith(movie: movie)
        self.presenter.present(movieDetailsVC, animated: true)
    }
}
