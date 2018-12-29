//
//  TVDetailsVM.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 29/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

struct TVDetailsData {
    let popularity: String
    let countAverage: String
    let count: String
    let originalName: String
    let genres: String
    let language: String
    let noOfSeasons: String
    let noOfEpisodes: String
    let runTimes: String
    let overview: String
    let createdBy: String
    let posterImageUrl: String
    let placeHolderImageName: String
}

protocol TVDetailsPresentable {
    var tvId: Int! { get set }
    var dataServices: DataServices! { get set }
    var displayDetails: ((TVDetailsData) -> ())? { get set }
    var didTapCloseBtnClosure: (() -> ())? { get set }
    func fetchTVDetails()
}

class TVDetailsVM: TVDetailsPresentable {
    var tvId: Int!
    var dataServices: DataServices!
    var displayDetails: ((TVDetailsData) -> ())?
    var didTapCloseBtnClosure: (() -> ())?
    
    private var tv: TV!
    
    func fetchTVDetails() {
        dataServices.getTVDetails(tvId: tvId) { [unowned self] (success, tv) in
            guard success, let tv = tv else { return }
            self.displayDetails?(self.tranform(tv: tv))
        }
    }
    
    private func tranform(tv: TV) -> TVDetailsData {
        var popularity = " "
        if let tvPopularity = tv.popularity {
            let popularityStr = String(format: "%.1f", tvPopularity)
            popularity = "☆ \(popularityStr)"
        }
        
        var countAverage = " "
        if let tvCountAverage = tv.voteAverage {
            let countAverageStr = String(format: "%.1f", tvCountAverage)
            countAverage = "♡ \(countAverageStr)"
        }
        
        var count = " "
        if let tvCount = tv.voteCount {
            count = "웃 \(tvCount)"
        }
        
        var originalName = " "
        if let tvOriginalName = tv.originalName {
            originalName = tvOriginalName
        }
        
        var genres = " "
        if let tvGenres = tv.genres, genres.count > 0 {
            var genresStr = tvGenres.reduce("") { genres, next in "\(genres), \(next)" }
            genresStr = String(genresStr.dropFirst(2))
            genres = genresStr
        }
        
        let language = tv.originalLanguage ?? " "
        
        let noOfSeasons = tv.noOfSeasons == nil ? " " : "\(tv.noOfSeasons!)"
        
        let noOfEpisodes = tv.noOfEpisodes == nil ? " " : "\(tv.noOfEpisodes!)"

        var runTimes = " "
        if let tvRunTimes = tv.episodeRunTime, runTimes.count > 0 {
            var runtimesStr = tvRunTimes.reduce("") { runtimesStr, nextRuntime in "\(runtimesStr), \(nextRuntime)" }
            runtimesStr = String(runtimesStr.dropFirst(2))
            runTimes = runtimesStr
        }
        
        let overview = tv.overview ?? " "
        
        var createdBy = " "
        if let tvCreatedBy = tv.createdBys, createdBy.count > 0 {
            var createdByText = tvCreatedBy.reduce("") { createdByStr, nextCreatedBy in "\(createdByStr), \(nextCreatedBy)" }
            createdByText = String(createdByText.dropFirst(2))
            createdBy = createdByText
        }
        
        let posterImageUrl = "https://image.tmdb.org/t/p/w500/\(tv.posterPath ?? "")"
        let placeHolderImageName = "movieNTV"
        
        return TVDetailsData(popularity: popularity, countAverage: countAverage, count: count, originalName: originalName, genres: genres, language: language, noOfSeasons: noOfSeasons, noOfEpisodes: noOfEpisodes, runTimes: runTimes, overview: overview, createdBy: createdBy, posterImageUrl: posterImageUrl, placeHolderImageName: placeHolderImageName)
    }
}

extension TVDetailsVM: TVDetailsViewDelegate {
    func didTapCloseBtn() {
        self.didTapCloseBtnClosure?()
    }
}
