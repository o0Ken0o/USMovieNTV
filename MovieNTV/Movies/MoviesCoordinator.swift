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
    
    init(presenter: UINavigationController, tabBarTag:Int) {
        self.presenter = presenter
        self.tabBarTag = tabBarTag
    }
    
    func start() {
        self.moviesVC = MoviesVC()
        self.moviesVC.edgesForExtendedLayout = []
        self.moviesVC.view.backgroundColor = .orange
        self.moviesVC.title = "Movies"
        self.moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie_icon"), tag: tabBarTag)
        
        self.presenter.pushViewController(moviesVC, animated: true)
        self.presenter.navigationBar.barTintColor = .black
        self.presenter.navigationBar.tintColor = .white
        self.presenter.navigationBar.isTranslucent = false
        self.presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
