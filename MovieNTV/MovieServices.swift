//
//  MovieServices.swift
//  MovieNTV
//
//  Created by Ken Siu on 20/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieServices {

    let apiKey = "ba0a292f6231bfc33b918d9c7cb31095"
    let baseURL = "https://api.themoviedb.org/3"
    let getImageBaseURL = "https://image.tmdb.org/t/p"
        
    // /movie/{movie_id}
    func getMovieDetails(movieID: Int, with completion: @escaping (_ success: Bool, _ movie: Movie?) -> ()) {
        let url = "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)"
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                completion(true, Movie(movieJSON: JSON(value)))
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /movie/latest
    func getLastest(with completion: @escaping (_ success: Bool, _ movie: Movie?) -> ()) {
        let url = "\(baseURL)/movie/latest?api_key=\(apiKey)"
        
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
    func getNowPlaying(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        let url = "\(baseURL)/movie/now_playing?api_key=\(apiKey)"
        var moviesArray = [Movie]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let moviesJSON = JSON(value)["results"].array {
                    for movieJSON in moviesJSON {
                        if let movie = Movie(movieJSON: movieJSON) {
                            moviesArray.append(movie)
                        }
                    }
                }
                completion(true, moviesArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /movie/popular
    func getPopular(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        let url = "\(baseURL)/movie/popular?api_key=\(apiKey)"
        var moviesArray = [Movie]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let moviesJSON = JSON(value)["results"].array {
                    for movieJSON in moviesJSON {
                        if let movie = Movie(movieJSON: movieJSON) {
                            moviesArray.append(movie)
                        }
                    }
                }
                completion(true, moviesArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /movie/top_rated
    func getTopRated(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        let url = "\(baseURL)/movie/top_rated?api_key=\(apiKey)"
        var moviesArray = [Movie]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let moviesJSON = JSON(value)["results"].array {
                    for movieJSON in moviesJSON {
                        if let movie = Movie(movieJSON: movieJSON) {
                            moviesArray.append(movie)
                        }
                    }
                }
                completion(true, moviesArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /movie/upcoming
    func getUpcoming(with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        let url = "\(baseURL)/movie/upcoming?api_key=\(apiKey)"
        var moviesArray = [Movie]()
        
        Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let moviesJSON = JSON(value)["results"].array {
                    for movieJSON in moviesJSON {
                        if let movie = Movie(movieJSON: movieJSON) {
                            moviesArray.append(movie)
                        }
                    }
                }
                completion(true, moviesArray)
            case .failure:
                completion(false, nil)
            }
        })
    }
    
    // /search/movie
    func searchMovies(query: String, with completion: @escaping (_ success: Bool, _ movie: [Movie]?) -> ()) {
        
        if query.characters.count == 0 {
            return
        }
        
        let queryEncode = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if let queryEncodeStr = queryEncode {
            let url = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(queryEncodeStr)"
            var moviesArray = [Movie]()
                        
            Alamofire.request(url).validate().responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    if let moviesJSON = JSON(value)["results"].array {
                        for movieJSON in moviesJSON {
                            if let movie = Movie(movieJSON: movieJSON) {
                                moviesArray.append(movie)
                            }
                        }
                    }
                    completion(true, moviesArray)
                case .failure:
                    completion(false, nil)
                }
            })
        }
    }
    
    func getImage(posterPath: String, with completion: @escaping (_ success: Bool, _ image: UIImage?) -> ()) {
        if let imageLocalPath = Utilities().checkImageExistence(imagePath: posterPath) {
            let data = FileManager.default.contents(atPath: imageLocalPath)
            let image = UIImage(data: data!)
            completion(true, image)
        } else {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                let url = "\(self.getImageBaseURL)/w500/\(posterPath)"
                var image: UIImage? = nil
                do {
                    let data = try Data(contentsOf: URL(string: url)!)
                    let escapedImageFullPath = "\(Utilities().getDocumentDirectory()!)/\(posterPath)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    
                    FileManager.default.createFile(atPath: escapedImageFullPath, contents: data, attributes: nil)
                    
                    DispatchQueue.main.async(execute: {
                        image = UIImage(data: data)
                        completion(true, image)
                    })
                } catch let error as NSError {
                    print(error.localizedDescription)
                } catch {
                    
                }
                
                completion(false, image)
            }
        }
    }
}
