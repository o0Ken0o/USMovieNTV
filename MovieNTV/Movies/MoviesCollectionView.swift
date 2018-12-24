//
//  MoviesCollectionView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView {
    private var _movies = [Movie]()
}

extension MoviesCollectionView: WithMovies {
    var movies: [Movie] {
        get {
            return _movies
        }
        set {
            _movies = newValue
        }
    }
}
