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
    func getLastest(with completion: @escaping (_ success: Bool, _ movie: Movie?) -> ()) {
        let url = "\(baseURL)/movie/latest?api_key=\(apiKey)"
        
        // TODO: fetch data in a background thread
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                completion(true, Movie(movieJSON: JSON(value)))
            case .failure:
                completion(false, nil)
            }
        })
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
