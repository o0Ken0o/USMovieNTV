//
//  TVsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol TVsVCDelegate: class {
    func didSelect(tv: TV)
}

class TVsVC: UIViewController, HasCustomView {
    typealias CustomView = TVsListView
    
    var dataServices: DataServices!
    weak var delegate: TVsVCDelegate?
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAiringToday()
        loadOnTheAir()
        loadPopular()
        loadTopRated()
    }
    
    private func loadAiringToday() {
        dataServices.getAiringToday { (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.customView.showAiringToday(tvs: tvs)
        }
    }
    
    private func loadOnTheAir() {
        dataServices.getTVOnTheAir { (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.customView.showOnTheAir(tvs: tvs)
        }
    }
    
    private func loadPopular() {
        dataServices.getTVPopular { (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.customView.showPopular(tvs: tvs)
        }
    }
    
    private func loadTopRated() {
        dataServices.getTVTopRated { (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.customView.showTopRated(tvs: tvs)
        }
    }
}

extension TVsVC: TVsListViewDelegate {
    func didSelect(tv: TV) {
        self.delegate?.didSelect(tv: tv)
    }
}
