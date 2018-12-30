//
//  MoviesHelper.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 30/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

struct MoviesHelper {
    static let shared = MoviesHelper()
    
    func transfrom(movie: Movie) -> MovieCellViewModel {
        let popularity = String(format: "%.1f", movie.popularity)
        let popularityStr = "☆ \(popularity)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let releaseDateStr = movie.releaseDate == nil ? "" : dateFormatter.string(from: movie.releaseDate!)
        
        let posterPath = "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"
        let placeHolderImageName = "movieNTV"
        
        return MovieCellViewModel(releaseDate: releaseDateStr, popularity: popularityStr, posterImageUrl: posterPath, placeHolderImageName: placeHolderImageName)
    }
}
