//
//  MoviesCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MoviesCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let tabBarTag: Int
    private var moviesVC: MoviesVC!
    private let dataServices: DataServices = DataServices.shared
    private var movieDetailsCoordinator: MovieDetailsCoordinator?
    
    init(presenter: UINavigationController, tabBarTag:Int) {
        self.presenter = presenter
        self.tabBarTag = tabBarTag
    }
    
    func start() {
        self.moviesVC = MoviesVC()
        self.moviesVC.delegate = self
        self.moviesVC.edgesForExtendedLayout = []
        self.moviesVC.title = "Movies"
        self.moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie_icon"), tag: tabBarTag)
        self.moviesVC.dataServices = dataServices
        
        self.presenter.pushViewController(moviesVC, animated: true)
        self.presenter.navigationBar.barTintColor = .black
        self.presenter.navigationBar.tintColor = .white
        self.presenter.navigationBar.isTranslucent = false
        self.presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension MoviesCoordinator: MoviesVCDelegate {
    func didSelect(movie: Movie) {
        self.movieDetailsCoordinator = MovieDetailsCoordinator(presenter: presenter, movie: movie)
        self.movieDetailsCoordinator?.start()
    }
}
