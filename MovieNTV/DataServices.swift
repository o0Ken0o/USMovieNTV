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
    
    let apiKey = "ba0a292f6231bfc33b918d9c7cb31095"
    let baseURL = "https://api.themoviedb.org/3"
    let getImageBaseURL = "https://image.tmdb.org/t/p"
    let movieDomain = "/movie"
    
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
