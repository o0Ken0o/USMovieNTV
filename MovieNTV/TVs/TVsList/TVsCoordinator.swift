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
    private var tvsVM: (TVsPresentable & TVsListViewDelegate)!
    private let dataServices: DataServices = DataServices.shared
    private var tvDetailsCoordinator: TVDetailsCoordinator!
    
    init(presenter: UINavigationController, tabBarTag:Int) {
        self.presenter = presenter
        self.tabBarTag = tabBarTag
    }
    
    func start() {
        self.tvsVM = TVsVM()
        self.tvsVM.dataServices = dataServices
        
        self.tvsVM.didSelectATV = { [unowned self] tv in
            self.didSelect(tv: tv)
        }
        
        self.tvsVC = TVsVC()
        self.tvsVC.edgesForExtendedLayout = []
        self.tvsVC.title = "TVs"
        self.tvsVC.tabBarItem = UITabBarItem(title: "TVs", image: UIImage(named: "tv_icon"), tag: tabBarTag)
        self.tvsVC.vm = self.tvsVM
        
        self.presenter.pushViewController(tvsVC, animated: true)
        self.presenter.navigationBar.barTintColor = .black
        self.presenter.navigationBar.tintColor = .white
        self.presenter.navigationBar.isTranslucent = false
        self.presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func didSelect(tv: TV) {
        tvDetailsCoordinator = TVDetailsCoordinator(presenter: presenter, tv: tv)
        tvDetailsCoordinator.start()
    }
}
