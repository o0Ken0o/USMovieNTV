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
    private var tvDetailsVM: (TVDetailsPresentable & TVDetailsViewDelegate)!
    private let dataServices: DataServices = DataServices.shared
    
    init(presenter: UINavigationController, tv: TV) {
        self.presenter = presenter
        self.tv = tv
    }
    
    func start() {
        self.tvDetailsVM = TVDetailsVM()
        self.tvDetailsVM.tvId = tv.id
        self.tvDetailsVM.dataServices = dataServices
        
        self.tvDetailsVM.didTapCloseBtnClosure = { [unowned self] in
            self.didTapCloseBtn()
        }
        
        self.tvDetailsVC = TVDetailsVC()
        self.tvDetailsVC.tvDetailsVM = self.tvDetailsVM
        
        self.presenter.present(tvDetailsVC, animated: true)
    }
    
    private func didTapCloseBtn() {
        self.tvDetailsVC.dismiss(animated: true)
    }
}
