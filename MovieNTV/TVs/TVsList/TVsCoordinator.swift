//
//  TVsCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVsCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let tabBarTag: Int
    private var tvsVC: TVsVC!
    private let dataServices: DataServices = DataServices.shared
    
    init(presenter: UINavigationController, tabBarTag:Int) {
        self.presenter = presenter
        self.tabBarTag = tabBarTag
    }
    
    func start() {
        self.tvsVC = TVsVC()
        self.tvsVC.edgesForExtendedLayout = []
        self.tvsVC.title = "TVs"
        self.tvsVC.tabBarItem = UITabBarItem(title: "TVs", image: UIImage(named: "tv_icon"), tag: tabBarTag)
        self.tvsVC.delegate = self
        self.tvsVC.dataServices = dataServices
        
        self.presenter.pushViewController(tvsVC, animated: true)
        self.presenter.navigationBar.barTintColor = .black
        self.presenter.navigationBar.tintColor = .white
        self.presenter.navigationBar.isTranslucent = false
        self.presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension TVsCoordinator: TVsVCDelegate {
    func didSelect(tv: TV) {
        
    }
}
