//
//  SearchVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol SearchVCDelegate: class {
    
}

class SearchVC: UIViewController, HasCustomView {
    typealias CustomView = SearchView
    
    weak var delegate: SearchVCDelegate?
    var dataServices: DataServices!
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
}

extension SearchVC: SearchViewDelegate {
    
}
