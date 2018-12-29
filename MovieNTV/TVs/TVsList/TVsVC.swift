//
//  TVsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVsVC: UIViewController, HasCustomView {
    typealias CustomView = TVsListView
    
    var vm: (TVsPresentable & TVsListViewDelegate)!
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = vm
        customView.vm = vm
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.showAiringToday = { [unowned self] in self.customView.showAiringToday() }
        vm.showOnTheAir = { [unowned self] in self.customView.showOnTheAir() }
        vm.showPopular = { [unowned self] in self.customView.showPopular() }
        vm.showTopRated = { [unowned self] in self.customView.showTopRated() }
        
        vm.fetchTVs()
    }
}
