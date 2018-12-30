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
    
    func transform(movie: Movie) -> MovieDetailsData {
        let tempPopularity = String(format: "%.1f", movie.popularity)
        let popularity = "☆ \(tempPopularity)"
        
        let count = "웃 \(movie.voteCount)"
        
        let countAverageStr = String(format: "%.1f", movie.voteAverage)
        let voteAverage = "♡ \(countAverageStr)"
        
        let title = movie.title
        
        var genres = " "
        if let movieGenres = movie.genres, genres.count > 0 {
            var genresStr = movieGenres.reduce("") { genres, next in "\(genres), \(next)" }
            genresStr = String(genresStr.dropFirst(2))
            genres = genresStr
        }
        
        var spokenLanguages = " "
        if let languages = movie.spokenLanguages, languages.count > 0 {
            var languagesStr = languages.reduce("") { languages, nextLanguage in "\(languages), \(nextLanguage)" }
            languagesStr = String(languagesStr.dropFirst(2))
            spokenLanguages = languagesStr
        }
        
        var productionCompanies = " "
        if let companies = movie.productionCompanies, companies.count > 0 {
            var companiesStr = companies.reduce("") { companiesStr, nextCompany in "\(companiesStr), \(nextCompany)" }
            companiesStr = String(companiesStr.dropFirst(2))
            productionCompanies = companiesStr
        }
        
        var productionCountries = " "
        if let countries = movie.productionCountries, countries.count > 0 {
            var countriesStr = countries.reduce("") { countriesStr, nextCountry in "\(countriesStr), \(nextCountry)" }
            countriesStr = String(countriesStr.dropFirst(2))
            productionCountries = countriesStr
        }
        
        var releaseDate = "--"
        if let movieReleaseDate = movie.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            releaseDate = dateFormatter.string(from: movieReleaseDate)
        }
        
        var runTimeMins = "--"
        if let runtime = movie.runTimeMins {
            runTimeMins = "\(runtime)"
        }
        
        let posterImageUrl = "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"
        let placeHolderImageName = "movieNTV"
        
        return MovieDetailsData.init(popularity: popularity, count: count, voteAverage: voteAverage, title: title, genres: genres, spokenLanguages: spokenLanguages, productionCompanies: productionCompanies, productionCountries: productionCountries, releaseDate: releaseDate, runTimeMins: runTimeMins, posterImageUrl: posterImageUrl, placeHolderImageName: placeHolderImageName)
    }
}
