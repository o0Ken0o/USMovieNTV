//
//  DataServices.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataServices {
    static let shared = DataServices()
    
    private let movieServices = MovieServices()
    private let tvServices = TVServices()
    
    // singleton
    private init() {}
    
    // /movie/{movie_id}
    func getMovieDetails(movieID: Int, with completion: @escaping (_ success: Bool, _ movie: Movie?) -> ()) {
        movieServices.getMovieDetails(movieID: movieID, with: completion)
    }
    
    // /movie/latest
    func getLastest(with completion: @escaping (_ success: Bool, _ movie: Movie?) -> ()) {
        movieServices.getLastest(with: completion)
    }
    
    // /movie/now_playing
    func getNowPlaying(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        movieServices.getNowPlaying(with: completion)
    }
    
    // /movie/popular
    func getPopular(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        movieServices.getPopular(with: completion)
    }
    
    // /movie/top_rated
    func getTopRated(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        movieServices.getTopRated(with: completion)
    }
    
    // /movie/upcoming
    func getUpcoming(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        movieServices.getUpcoming(with: completion)
    }
    
    // /tv/airing_today
    func getAiringToday(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()){
        tvServices.getAiringToday(with: completion)
    }
    
    // /tv/on_the_air
    func getTVOnTheAir(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        tvServices.getTVOnTheAir(with: completion)
    }
    
    // /tv/popular
    func getTVPopular(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        tvServices.getTVPopular(with: completion)
    }
    
    // /tv/top_rated
    func getTVTopRated(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        tvServices.getTVTopRated(with: completion)
    }
    
    func getTVDetails(tvId: Int, with completion: @escaping (_ success: Bool, _ tv: TV?) -> ()) {
        tvServices.getTVDetails(tvId: tvId, with: completion)
    }
    
    func getImage(posterPath: String, with completion: @escaping (_ success: Bool, _ image: UIImage?) -> ()) {
        movieServices.getImage(posterPath: posterPath, with: completion)
    }
}
