//
//  TVServices.swift
//  MovieNTV
//
//  Created by Ken Siu on 20/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TVServices {
    let apiKey = "ba0a292f6231bfc33b918d9c7cb31095"
    let baseURL = "https://api.themoviedb.org/3"
    let getImageBaseURL = "https://image.tmdb.org/t/p"
    
    // /tv/airing_today
    func getAiringToday(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        let url = "\(baseURL)/tv/airing_today?api_key=\(apiKey)"
        var tvShowsArray = [TV]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let tvsJSON = JSON(value)["results"].array {
                    for tvJSON in tvsJSON {
                        if let tv = TV(tvJSON: tvJSON) {
                            tvShowsArray.append(tv)
                        }
                    }
                }
                completion(true, tvShowsArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /tv/tvId
    func getTVDetails(tvId: Int, with completion: @escaping (_ success: Bool, _ tv: TV?) -> ()) {
        let url = "\(baseURL)/tv/\(tvId)?api_key=\(apiKey)"
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let tv = TV(tvJSON: JSON(value))
                completion(true, tv)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /tv/on_the_air
    func getTVOnTheAir(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        let url = "\(baseURL)/tv/on_the_air?api_key=\(apiKey)"
        var tvShowsArray = [TV]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let tvsJSON = JSON(value)["results"].array {
                    for tvJSON in tvsJSON {
                        if let tv = TV(tvJSON: tvJSON) {
                            tvShowsArray.append(tv)
                        }
                    }
                }
                completion(true, tvShowsArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /tv/popular
    func getTVPopular(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        let url = "\(baseURL)/tv/popular?api_key=\(apiKey)"
        var tvShowsArray = [TV]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let tvsJSON = JSON(value)["results"].array {
                    for tvJSON in tvsJSON {
                        if let tv = TV(tvJSON: tvJSON) {
                            tvShowsArray.append(tv)
                        }
                    }
                }
                completion(true, tvShowsArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /tv/top_rated
    func getTVTopRated(with completion: @escaping (_ success: Bool, _ tvs: [TV]?) -> ()) {
        let url = "\(baseURL)/tv/top_rated?api_key=\(apiKey)"
        var tvShowsArray = [TV]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let tvsJSON = JSON(value)["results"].array {
                    for tvJSON in tvsJSON {
                        if let tv = TV(tvJSON: tvJSON) {
                            tvShowsArray.append(tv)
                        }
                    }
                }
                completion(true, tvShowsArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /search/tv
    func searchTVShows(query: String, with completion: @escaping (_ success: Bool, _ movie: [TV]?) -> ()) {
        if query.characters.count == 0 {
            return
        }
        
        let queryEncode = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if let queryEncodeStr = queryEncode {
            let url = "\(baseURL)/search/tv?api_key=\(apiKey)&query=\(queryEncodeStr)"
            var tvsArray = [TV]()
                        
            Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    if let tvsJSON = JSON(value)["results"].array {
                        for tvJSON in tvsJSON {
                            if let tv = TV(tvJSON: tvJSON) {
                                tvsArray.append(tv)
                            }
                        }
                    }
                    completion(true, tvsArray)
                case .failure:
                    completion(false, nil)
                }
            })
        }
    }
    
}
