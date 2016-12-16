//
//  DataServices.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation

class DataServices {
    static let sharedInstance = DataServices()
    
    let apiKey = "ba0a292f6231bfc33b918d9c7cb31095"
    let baseURL = "https://api.themoviedb.org/3"
    let getImageBaseURL = "https://image.tmdb.org/t/p"
    let movieDomain = "/movie"
    
    private init() {
        
    }
    
    // /movie/{movie_id}
    func getMovieDetails() -> Movie? {
        return nil
    }
    
    // /movie/latest
    func getLastest() -> [Movie]? {
        return nil
    }
    
    // /movie/now_playing
    func getNowPlaying() -> [Movie]? {
        return nil
    }
    
    // /movie/popular
    func getPopular() -> [Movie]? {
        return nil
    }
    
    // /movie/top_rated
    func getTopRated() -> [Movie]? {
        return nil
    }
    
    // /movie/upcoming
    func getUpcoming() -> [Movie]? {
        return nil
    }
}
