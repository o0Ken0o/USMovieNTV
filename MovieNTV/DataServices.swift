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
    func getTopRated() -> [Movie]? {
        return nil
    }
    
    // /movie/upcoming
    func getUpcoming() -> [Movie]? {
        return nil
    }
    
    func getImage(posterPath: String, with completion: @escaping (_ success: Bool, _ image: UIImage?) -> ()) {
        if let imageLocalPath = checkImageExistence(imagePath: posterPath) {
            let data = FileManager.default.contents(atPath: imageLocalPath)
            let image = UIImage(data: data!)
            completion(true, image)
        } else {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                let url = "\(self.getImageBaseURL)/w500/\(posterPath)"
                var image: UIImage? = nil
                do {
                    let data = try Data(contentsOf: URL(string: url)!)
                    let escapedImageFullPath = "\(self.getDocumentDirectory()!)/\(posterPath)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    
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
    
    private func checkImageExistence(imagePath: String) -> String? {
        if let docPath = getDocumentDirectory() {
            let imageFullPath = "\(docPath)/\(imagePath)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            if FileManager.default.fileExists(atPath: imageFullPath!) {
                return imageFullPath
            }
        }
        
        return nil
    }
    
    private func getDocumentDirectory() -> String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
}
