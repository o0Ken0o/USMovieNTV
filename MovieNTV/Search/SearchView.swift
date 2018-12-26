//
//  SearchView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
    
}

class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
}
