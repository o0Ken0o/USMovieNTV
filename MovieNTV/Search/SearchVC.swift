//
//  SearchVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, HasCustomView {
    typealias CustomView = SearchView
    
    var searchVM: (SearchViewPresentable & SearchViewDelegate)!
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = searchVM
        customView.searchVM = searchVM
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVM.showSearchResults = { [unowned self] in
            self.customView.resultView.reloadData()
        }
    }
}
