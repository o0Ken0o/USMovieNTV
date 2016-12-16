//
//  Movie.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation

struct Moive {
    /* TODO: belongsToCollection, genres, productionCompanies, productionContries, spoken_languages
        a specific struct or enum should be created for each of them
    */
    var adult: Bool
    var backdropPath: String
    var belongsToCollection: [AnyObject]?
    var budget: Int
    var genres: [AnyObject]
    var homepage: String?
    var id: Int
    var imdbId: Int
    var originalLanguage: String
    var originalTitle: String
    var popularity: Float
    var posterPath: String
    var productionCompanies: [AnyObject]
    var productionCountries: [AnyObject]
    var releaseDate: Date
    var revenueUSD: Int
    var runTimeMins: Int
    var spokenLanguages: [AnyObject]
    var status: String
    var tagLine: String
    var title: String
    var video: Bool
    var voteAverage: Float
    var voteCount: Int
    
    init(adult: Bool, backdropPath: String, budget: Int, genres: [AnyObject], homepage: String?, id: Int, imdbId: Int, originalLanguage: String, originalTitle: String, popularity: Float, posterPath: String, productionCompanies: [AnyObject], productionCountries: [AnyObject], releaseDate: Date, revenueUSD: Int, runTimeMins: Int, spokenLanguages: [AnyObject], status: String, tagLine: String, title: String, video: Bool, voteAverage: Float, voteCount: Int) {
        
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenueUSD = revenueUSD
        self.runTimeMins = runTimeMins
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagLine = tagLine
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
