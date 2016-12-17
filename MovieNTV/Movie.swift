//
//  Movie.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Movie {
    var adult: Bool = false
    var backdropPath: String?
    var belongsToCollection: [JSON]?
    var budget: Int = 0
    var genres: [JSON]?
    var homepage: String?
    var id: Int = -1
    var imdbId: String?
    var originalLanguage: String
    var originalTitle: String
    var overview: String?
    var popularity: Float
    var posterPath: String?
    var productionCompanies: [JSON]?
    var productionCountries: [JSON]?
    var releaseDate: Date?
    var revenueUSD: Int
    var runTimeMins: Int?
    var spokenLanguages: [JSON]?
    var status: String
    var tagLine: String?
    var title: String
    var video: Bool
    var voteAverage: Float
    var voteCount: Int
    
    init?(movieJSON: JSON) {
        if let tempId = movieJSON["id"].int {
            id = tempId
        } else {
            return nil
        }
        
        if let adult = movieJSON["adult"].bool {
            self.adult = adult
        } else {
            self.adult = false
        }
        
        if let backdrop_path = movieJSON["backdrop_path"].string {
            self.backdropPath = backdrop_path
        } else {
            self.backdropPath = nil
        }
        
        if let belongs_to_collection = movieJSON["belongs_to_collection"].array {
            self.belongsToCollection = belongs_to_collection
        } else {
            self.belongsToCollection = nil
        }
        
        if let budget = movieJSON["budget"].int {
            self.budget = budget
        } else {
            self.budget = 0
        }
        
        if let genres = movieJSON["genres"].array {
            self.genres = genres
        } else {
            self.genres = nil
        }
        
        if let homepage = movieJSON["homepage"].string {
            self.homepage = homepage
        } else {
            self.homepage = nil
        }
        
        if let imdb_id = movieJSON["imdb_id"].string {
            self.imdbId = imdb_id
        } else {
            self.imdbId = nil
        }
        
        if let original_language = movieJSON["original_language"].string {
            self.originalLanguage = original_language
        } else {
            self.originalLanguage = "en"
        }
        
        if let original_title = movieJSON["original_title"].string {
            self.originalTitle = original_title
        } else {
            self.originalTitle = ""
        }
        
        if let overview = movieJSON["overview"].string {
            self.overview = overview
        } else {
            self.overview = ""
        }
        
        if let popularity = movieJSON["popularity"].float {
            self.popularity = popularity
        } else {
            self.popularity = 0
        }
        
        if let poster_path = movieJSON["poster_path"].string {
            self.posterPath = poster_path
        } else {
            self.posterPath = nil
        }
        
        if let production_companies = movieJSON["production_companies"].array {
            self.productionCompanies = production_companies
        } else {
            self.productionCompanies = nil
        }
        
        if let production_countries = movieJSON["production_countries"].array {
            self.productionCountries = production_countries
        } else {
            self.productionCountries = nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        if let release_date = movieJSON["release_date"].string, let dateFormatted = dateFormatter.date(from: release_date) {
            self.releaseDate = dateFormatted
        } else {
            self.releaseDate = nil
        }
        
        if let revenueUSD = movieJSON["revenue"].int {
            self.revenueUSD = revenueUSD
        } else {
            self.revenueUSD = 0
        }
        
        if let runtimeMins = movieJSON["runtime"].int {
            self.runTimeMins = runtimeMins
        } else {
            self.runTimeMins = nil
        }
        
        if let spoken_languages = movieJSON["spoken_languages"].array {
            self.spokenLanguages = spoken_languages
        } else {
            self.spokenLanguages = nil
        }
        
        if let status = movieJSON["status"].string {
            self.status = status
        } else {
            self.status = ""
        }
        
        if let tagline = movieJSON["tagline"].string {
            self.tagLine = tagline
        } else {
            self.tagLine = ""
        }
        
        if let title = movieJSON["title"].string {
            self.title = title
        } else {
            self.title = ""
        }
        
        if let video = movieJSON["video"].string {
            self.video = NSString(string: video).boolValue
        } else {
            self.video = false
        }
        
        if let vote_average_str = movieJSON["vote_average"].string, let vote_average_float = Float(vote_average_str) {
            self.voteAverage = vote_average_float
        } else {
            self.voteAverage = 0
        }
        
        if let vote_count_str = movieJSON["vote_count"].string, let vote_count_int = Int(vote_count_str) {
            self.voteCount = vote_count_int
        } else {
            self.voteCount = 0
        }

    }
    
    init(adult: Bool, backdropPath: String?, budget: Int, genres: [JSON]?, homepage: String?, id: Int, imdbId: String?, originalLanguage: String, originalTitle: String, overview: String?, popularity: Float, posterPath: String?, productionCompanies: [JSON]?, productionCountries: [JSON]?, releaseDate: Date?, revenueUSD: Int, runTimeMins: Int?, spokenLanguages: [JSON]?, status: String, tagLine: String?, title: String, video: Bool, voteAverage: Float, voteCount: Int) {
        
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
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
