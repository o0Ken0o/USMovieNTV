//
//  TVDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVDetailsVC: UIViewController, HasCustomView {
    typealias CustomView = TVDetailsView
    
    var tvId: Int!
    var tvDetailsVM: (TVDetailsPresentable & TVDetailsViewDelegate)!
    
    override func loadView() {
        let customView = TVDetailsView()
        customView.delegate = tvDetailsVM
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        tvDetailsVM.displayDetails = { [unowned self] tvDetailsData in
            self.customView.displayWith(tvDetailsData: tvDetailsData)
        }
        
        tvDetailsVM.fetchTVDetails()
    }
}
