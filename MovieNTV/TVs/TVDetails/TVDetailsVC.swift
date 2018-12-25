//
//  TVDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol TVDetailsVCDelegate: class {
    func didTapCloseBtn()
}

class TVDetailsVC: UIViewController, HasCustomView {
    typealias CustomView = TVDetailsView
    
    var tvId: Int!
    var dataServices: DataServices!
    weak var delegate: TVDetailsVCDelegate?
    
    override func loadView() {
        let customView = TVDetailsView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
    }
}

extension TVDetailsVC: TVDetailsViewDelegate {
    func didTapCloseBtn() {
        self.delegate?.didTapCloseBtn()
    }
}
