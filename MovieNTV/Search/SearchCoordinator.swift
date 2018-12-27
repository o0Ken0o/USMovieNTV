//
//  SearchCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class SearchCoordinator: BaseCoordinator {
    private let dataServices: DataServices = DataServices.shared
    private let tabBarTag: Int
    private let presenter: UINavigationController!
    private var searchVC: SearchVC!
    private var movieDetailsCoordinator: MovieDetailsCoordinator!
    private var tvDetailsCoordinator: TVDetailsCoordinator!
    
    init(presenter: UINavigationController, tabBarTag: Int) {
        self.presenter = presenter
        self.tabBarTag = tabBarTag
    }
    
    func start() {
        self.searchVC = SearchVC()
        self.searchVC.edgesForExtendedLayout = []
        self.searchVC.title = "Search"
        self.searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search_icon"), tag: tabBarTag)
        
        self.searchVC.delegate = self
        self.searchVC.dataServices = dataServices
        
        self.presenter.pushViewController(searchVC, animated: true)
        self.presenter.navigationBar.barTintColor = .black
        self.presenter.navigationBar.tintColor = .white
        self.presenter.navigationBar.isTranslucent = false
        self.presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension SearchCoordinator: SearchVCDelegate {
    func didSelect(movie: Movie) {
        self.movieDetailsCoordinator = MovieDetailsCoordinator(presenter: presenter, movie: movie)
        self.movieDetailsCoordinator.start()
    }
    
    func didSelect(tv: TV) {
        self.tvDetailsCoordinator = TVDetailsCoordinator(presenter: presenter, tv: tv)
        self.tvDetailsCoordinator.start()
    }
}
