//
//  MovieDetailsViewModel.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 29/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

protocol MovieDetailsPresentable {
    var popularity: String! { get }
    var count: String! { get }
    var voteAverage: String! { get }
    var title: String! { get }
    var genres: String! { get }
    var spokenLanguages: String! { get }
    var productionCompanies: String! { get }
    var productionCountries: String! { get }
    var releaseDate: String! { get }
    var runTimeMins: String! { get }
    var posterImageUrl: String! { get }
    var placeHolderImageName: String! { get }
    var displayDetails: (() -> ())? { get set }
    
    func fetchMovieDetails()
    
    var dataServices: DataServices! { get set }
    var movieId: Int! { get set }
}

class MovieDetailsViewModel: MovieDetailsPresentable {
    var popularity: String!
    var count: String!
    var voteAverage: String!
    var title: String!
    var genres: String!
    var spokenLanguages: String!
    var productionCompanies: String!
    var productionCountries: String!
    var releaseDate: String!
    var runTimeMins: String!
    var posterImageUrl: String!
    var placeHolderImageName: String!
    var displayDetails: (() -> ())?
    
    var dataServices: DataServices!
    var movieId: Int!
    
    private func parse(movie: Movie) {
        let tempPopularity = String(format: "%.1f", movie.popularity)
        popularity = "☆ \(tempPopularity)"
        
        count = "웃 \(movie.voteCount)"
        
        let countAverageStr = String(format: "%.1f", movie.voteAverage)
        voteAverage = "♡ \(countAverageStr)"
        
        title = movie.title
        
        genres = " "
        if let genres = movie.genres, genres.count > 0 {
            var genresStr = genres.reduce("") { genres, next in "\(genres), \(next)" }
            genresStr = String(genresStr.dropFirst(2))
            self.genres = genresStr
        }
        
        spokenLanguages = " "
        if let languages = movie.spokenLanguages, languages.count > 0 {
            var languagesStr = languages.reduce("") { languages, nextLanguage in "\(languages), \(nextLanguage)" }
            languagesStr = String(languagesStr.dropFirst(2))
            spokenLanguages = languagesStr
        }
        
        productionCompanies = " "
        if let companies = movie.productionCompanies, companies.count > 0 {
            var companiesStr = companies.reduce("") { companiesStr, nextCompany in "\(companiesStr), \(nextCompany)" }
            companiesStr = String(companiesStr.dropFirst(2))
            productionCompanies = companiesStr
        }
        
        productionCountries = " "
        if let countries = movie.productionCountries, countries.count > 0 {
            var countriesStr = countries.reduce("") { countriesStr, nextCountry in "\(countriesStr), \(nextCountry)" }
            countriesStr = String(countriesStr.dropFirst(2))
            productionCountries = countriesStr
        }
        
        self.releaseDate = "--"
        if let releaseDate = movie.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            self.releaseDate = dateFormatter.string(from: releaseDate)
        }
        
        runTimeMins = "--"
        if let runtime = movie.runTimeMins {
            runTimeMins = "\(runtime)"
        }
        
        posterImageUrl = "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"
        placeHolderImageName = "movieNTV"
    }
    
    func fetchMovieDetails() {
        dataServices.getMovieDetails(movieID: movieId) { [unowned self] (success, movie) in
            if success, let movie = movie {
                self.parse(movie: movie)
                self.displayDetails?()
            }
        }
    }
}
