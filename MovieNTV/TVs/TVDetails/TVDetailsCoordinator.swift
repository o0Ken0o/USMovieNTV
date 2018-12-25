//
//  TVDetailsCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVDetailsCoordinator: BaseCoordinator {
    private let tv: TV
    private let presenter: UINavigationController
    private var tvDetailsVC: TVDetailsVC!
    private let dataServices: DataServices = DataServices.shared
    
    init(presenter: UINavigationController, tv: TV) {
        self.presenter = presenter
        self.tv = tv
    }
    
    func start() {
        self.tvDetailsVC = TVDetailsVC()
        self.tvDetailsVC.tvId = tv.id
        self.tvDetailsVC.delegate = self
        self.tvDetailsVC.dataServices = dataServices
        
        self.presenter.present(tvDetailsVC, animated: true)
    }
}

extension TVDetailsCoordinator: TVDetailsVCDelegate {
    func didTapCloseBtn() {
        self.tvDetailsVC.dismiss(animated: true)
    }
}
