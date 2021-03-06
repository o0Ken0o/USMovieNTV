//
//  DataServices.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import SwiftyJSON

class DataServices {
    static let shared = DataServices()
    
    private let movieServices = MovieServices()
    private let tvServices = TVServices()
    
    // singleton
    private init() {}
    
    // /movie/{movie_id}
    func getMovieDetails(movieID: Int) -> Observable<Movie> {
        return movieServices.getMovieDetails(movieID: movieID)
    }
    
    // /movie/latest
    func getLastest(with completion: @escaping (_ success: Bool, _ movie: Movie?) -> ()) {
        movieServices.getLastest(with: completion)
    }
    
    // /movie/now_playing
    func getNowPlaying() -> Observable<[Movie]> {
        return movieServices.getNowPlaying()
    }
    
    // /movie/popular
    func getPopular() -> Observable<[Movie]> {
        return movieServices.getPopular()
    }
    
    // /movie/top_rated
    func getTopRated() -> Observable<[Movie]> {
        return movieServices.getTopRated()
    }
    
    // /movie/upcoming
    func getUpcoming() -> Observable<[Movie]> {
        return movieServices.getUpcoming()
    }
    
    // /search/movie
    func searchMovies(query: String, with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        movieServices.searchMovies(query: query, with: completion)
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
    
    // /search/tv
    func searchTVShows(query: String, with completion: @escaping (_ success: Bool, _ movie: [TV]?) -> ()) {
        tvServices.searchTVShows(query: query, with: completion)
    }
    
    func getTVDetails(tvId: Int) -> Observable<TV> {
        return tvServices.getTVDetails(tvId: tvId)
    }
    
    func getImage(posterPath: String, with completion: @escaping (_ success: Bool, _ image: UIImage?) -> ()) {
        movieServices.getImage(posterPath: posterPath, with: completion)
    }
}
