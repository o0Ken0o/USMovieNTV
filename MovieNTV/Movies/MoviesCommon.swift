//
//  MoviesCommon.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 23/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

enum MovieType: Int {
    case nowPlaying, popular, topRated, upComing
    
    var header: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Related"
        case .upComing:
            return "Upcoming"
        }
    }
}

protocol MediaCellViewModel {}

struct MovieCellViewModel: MediaCellViewModel {
    let releaseDate: String
    let popularity: String
    let posterImageUrl: String
    let placeHolderImageName: String
}

protocol WithMovies {
    var movies: [Movie] { get set }
}
