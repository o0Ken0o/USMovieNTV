//
//  AppCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let rootVC: UITabBarController
    private var moviesCoordinator: MoviesCoordinator!
    private var tvsCoordinator: TVsCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        self.rootVC = UITabBarController()
    }
    
    func start() {
        let firstVC = UINavigationController()
        let secondVC = UINavigationController()
        let controllers = [firstVC, secondVC]
        
        self.rootVC.viewControllers = controllers
        self.rootVC.tabBar.barTintColor = .black
        self.rootVC.tabBar.tintColor = .white
        self.rootVC.tabBar.isTranslucent = false
        
        self.window.rootViewController = rootVC
        self.window.makeKeyAndVisible()
        
        self.moviesCoordinator = MoviesCoordinator(presenter: firstVC, tabBarTag: 0)
        self.tvsCoordinator = TVsCoordinator(presenter: secondVC, tabBarTag: 1)
        
        self.moviesCoordinator.start()
        self.tvsCoordinator.start()
    }
}
