//
//  TVDetailsCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TVDetailsCoordinator: BaseCoordinator {
    private let tv: TV
    private let presenter: UINavigationController
    private var tvDetailsVC: TVDetailsVC!
    private var tvDetailsVM: (TVDetailsPresentable & TVDetailsReactable)!
    private let dataServices: DataServices = DataServices.shared
    private let tvsHelper = TVsHelper.shared
    private let disposeBag = DisposeBag()
    
    init(presenter: UINavigationController, tv: TV) {
        self.presenter = presenter
        self.tv = tv
    }
    
    func start() {
        self.tvDetailsVM = TVDetailsVM(dataServices: dataServices, tvId: tv.id, tvsHelper: tvsHelper, disposeBag: disposeBag)
        
        self.tvDetailsVM.closeScreen
            .subscribe(onNext: { [unowned self] in
                self.didTapCloseBtn()
            })
            .disposed(by: disposeBag)
        
        self.tvDetailsVC = TVDetailsVC()
        self.tvDetailsVC.disposeBag = disposeBag
        self.tvDetailsVC.tvDetailsVM = self.tvDetailsVM
        
        self.presenter.present(tvDetailsVC, animated: true)
    }
    
    private func didTapCloseBtn() {
        self.tvDetailsVC.dismiss(animated: true)
    }
}
