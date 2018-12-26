//
//  SearchVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol SearchVCDelegate: class {
    
}

class SearchVC: UIViewController, HasCustomView {
    typealias CustomView = SearchView
    
    weak var delegate: SearchVCDelegate?
    var dataServices: DataServices!
    private var currentKeywords: String?
    private var resultMoviesArray = [Movie]()
    private var resultTVsArray = [TV]()
    
    private var searchFired: Int = 0 {
        didSet {
            if searchFired == 2 {
                searchComplete()
            }
        }
    }
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    private func searchMovies(_ keywords: String) {
        dataServices.searchMovies(query: keywords) { (success, movies) in
            if success, let movies = movies {
                self.resultMoviesArray = movies
                self.searchFired += 1
            }
        }
    }
    
    private func searchTVs(_ keywords: String) {
        dataServices.searchTVShows(query: keywords, with: { (success, tvs) in
            if success, let tvs = tvs {
                self.resultTVsArray = tvs
                self.searchFired += 1
            }
        })
    }
    
    private func searchComplete() {
        self.customView.showResult(movies: resultMoviesArray, tvs: resultTVsArray)
    }
}

extension SearchVC: SearchViewDelegate {
    func searchWith(words: String?) {
        if currentKeywords != words {
            currentKeywords = words
        }
        
        guard let words = currentKeywords else { return }
        searchFired = 0
        resultMoviesArray = []
        resultTVsArray = []
        searchMovies(words)
        searchTVs(words)
    }
}
