//
//  TVsCommon.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

enum TVType: Int {
    case airingToday, onTheAir, popular, topRated
    
    var header: String {
        switch self {
        case .airingToday:
            return "Airing Today"
        case .onTheAir:
            return "On The Air"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}

struct TVCellVM: MediaCellViewModel {
    let releaseDate: String
    let popularity: String
    let posterImageUrl: String
    let placeHolderImageName: String
}

protocol HasTVs {
    var tvs: [TV] { get set }
}
