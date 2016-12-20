//
//  TV.swift
//  MovieNTV
//
//  Created by Ken Siu on 20/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TV {
    var id: Int
    var originalName: String?
    var genres: [String]?
    var originalLanguage: String?
    var createdBys: [String]?
    var noOfSeasons: Int?
    var noOfEpisodes: Int?
    var episodeRunTime: [Int]?
    var overview: String?
    var posterPath: String?
    var firstAirDate: Date?
    var popularity: Float?
    
    init?(tvJSON: JSON) {
        if let id = tvJSON["id"].int {
            self.id = id
        } else {
            return nil
        }
        
        if let originalName = tvJSON["original_name"].string {
            self.originalName = originalName
        }
        
        if let genres = tvJSON["genres"].array {
            if genres.count > 0 {
                self.genres = [String]()
                for genre in genres {
                    if let genreStr = genre["name"].string {
                        self.genres?.append(genreStr)
                    }
                }
            }
        }
        
        if let originalLanguage = tvJSON["original_language"].string {
            self.originalLanguage = originalLanguage
        }
        
        if let createdBys = tvJSON["created_by"].array {
            if createdBys.count > 0 {
                self.createdBys = [String]()
                for createdBy in createdBys {
                    if let createdByStr = createdBy["name"].string {
                        self.createdBys?.append(createdByStr)
                    }
                }
            }
        }
        
        if let noOfSeasons = tvJSON["number_of_seasons"].int {
            self.noOfSeasons = noOfSeasons
        }
        
        if let noOfEpisodes = tvJSON["number_of_episodes"].int {
            self.noOfEpisodes = noOfEpisodes
        }
        
        if let episodeRunTime = tvJSON["episode_run_time"].array {
            if episodeRunTime.count > 0 {
                self.episodeRunTime = [Int]()
                for eachRunTStr in episodeRunTime {
                    if let eachRunTInt = eachRunTStr.int {
                        self.episodeRunTime?.append(eachRunTInt)
                    }
                }
            }
        }
        
        if let overview = tvJSON["overview"].string {
            self.overview = overview
        }
        
        if let posterPath = tvJSON["poster_path"].string {
            self.posterPath = posterPath
        }
        
        if let firstAirDate = tvJSON["first_air_date"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            self.firstAirDate = dateFormatter.date(from: firstAirDate)
        }
        
        if let popularity = tvJSON["popularity"].float {
            self.popularity = popularity
        }
    }
}
