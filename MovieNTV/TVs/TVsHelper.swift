//
//  TVsHelper.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 30/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

struct TVsHelper {
    static let shared = TVsHelper()
    
    func tranform(tv: TV) -> TVCellVM {
        var releaseDate = ""
        if let firstAirDate = tv.firstAirDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            releaseDate = dateFormatter.string(from: firstAirDate)
        }
        
        var popularity = ""
        if let tvPopularity = tv.popularity {
            let popularityStr = String(format: "%.1f", tvPopularity)
            popularity = "☆ \(popularityStr)"
        }
        
        let posterImageUrl = "https://image.tmdb.org/t/p/w500/\(tv.posterPath ?? "")"
        let placeHolderImageName = "movieNTV"
        
        return TVCellVM(releaseDate: releaseDate, popularity: popularity, posterImageUrl: posterImageUrl, placeHolderImageName: placeHolderImageName)
    }
}
