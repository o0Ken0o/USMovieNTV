//
//  SearchViewModel.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 29/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol SearchViewPresentable {
    var dataServices: DataServices! { get set }
    var moviesHelper: MoviesHelper! { get set }
    var tvsHelper: TVsHelper! { get set }
    var showSearchResults: (() -> ())? { get set }
    var didSelectAMovieClosure: ((Movie) -> ())? { get set }
    var didSelectATVClosure: ((TV) -> ())? { get set }
    
    func numberOfSection() -> Int
    func numberOfitems(section: Int) -> Int
    func cellVM(indexPath: IndexPath) -> MediaCellViewModel
    func headerSize() -> CGSize
}

class SearchViewModel: SearchViewPresentable {
    var dataServices: DataServices!
    var moviesHelper: MoviesHelper!
    var tvsHelper: TVsHelper!
    var showSearchResults: (() -> ())?
    var didSelectAMovieClosure: ((Movie) -> ())?
    var didSelectATVClosure: ((TV) -> ())?
    
    private var currentKeywords: String?
    private var resultMoviesArray = [Movie]()
    private var resultTVsArray = [TV]()
    private var resultMovieCellVMs = [MovieCellViewModel]()
    private var resultTVCellVMs = [TVCellVM]()
    
    func numberOfSection() -> Int {
        return 2
    }
    
    func numberOfitems(section: Int) -> Int {
        if section == 0 {
            return resultMovieCellVMs.count
        } else {
            return resultTVCellVMs.count
        }
    }
    
    func cellVM(indexPath: IndexPath) -> MediaCellViewModel {
        if indexPath.section == 0 {
            return resultMovieCellVMs[indexPath.row]
        } else {
            return resultTVCellVMs[indexPath.row]
        }
    }
    
    func headerSize() -> CGSize {
        if resultMoviesArray.count == 0 && resultTVsArray.count == 0 {
            return .zero
        }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 40)
    }
    
    private var searchFired: Int = 0 {
        didSet {
            if searchFired == 2 {
                searchComplete()
            }
        }
    }
    
    private func searchMovies(_ keywords: String) {
        dataServices.searchMovies(query: keywords) { (success, movies) in
            if success, let movies = movies {
                self.resultMoviesArray = movies
                self.resultMovieCellVMs = self.resultMoviesArray.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
                self.searchFired += 1
            }
        }
    }
    
    private func searchTVs(_ keywords: String) {
        dataServices.searchTVShows(query: keywords, with: { (success, tvs) in
            if success, let tvs = tvs {
                self.resultTVsArray = tvs
                self.resultTVCellVMs = self.resultTVsArray.map{ [unowned self] in self.tvsHelper.tranform(tv: $0)}
                self.searchFired += 1
            }
        })
    }
    
    private func searchComplete() {
        self.showSearchResults?()
    }
}

extension SearchViewModel: SearchViewDelegate {
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
    
    func didSelectACell(indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.didSelectAMovieClosure?(resultMoviesArray[indexPath.row])
        } else if indexPath.section == 1 {
            self.didSelectATVClosure?(resultTVsArray[indexPath.row])
        }
    }
}
