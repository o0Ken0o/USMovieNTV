//
//  TVsCollectionView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVsCollectionView: UICollectionView {
    private var _tvs: [TV] = []
}

extension TVsCollectionView: HasTVs {
    var tvs: [TV] {
        get {
            return _tvs
        }
        set {
            _tvs = newValue
        }
    }
    
    
}
