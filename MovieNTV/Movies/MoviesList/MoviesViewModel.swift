//
//  MoviesViewModel.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 28/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol MoviesViewPresentable {
    var showNowPlayingClosure: (([Movie]) -> ())? { get set }
    var showPopularClosure: (([Movie]) -> ())? { get set }
    var showTopRatedClosure: (([Movie]) -> ())? { get set }
    var showUpComingClosure: (([Movie]) -> ())? { get set }
    var itemSize: CGSize { get }
    var headerSize: CGSize { get }
    var itemHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
    
    func fetchMovies()
    func numberOfRows(collectionView: UICollectionView) -> Int
}

class MoviesViewModel: MoviesViewPresentable {
    private let dataServices: DataServices
    private var nowPlayingMovies = [Movie]()
    private var popularMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var upComingMovies = [Movie]()
    
    private let itemWidth: CGFloat = {
        return  UIScreen.main.bounds.size.width / 3
    }()
    
    lazy var itemHeight: CGFloat = {
        return itemWidth * 1.3
    }()
    
    lazy var itemSize: CGSize = {
        return CGSize(width: itemWidth, height: itemHeight)
    }()
    
    let headerHeight: CGFloat = {
        return CGFloat(60.0)
    }()
    
    let headerWidth: CGFloat = {
        return UIScreen.main.bounds.size.width / 3
    }()
    
    lazy var headerSize: CGSize = {
        return CGSize(width: headerWidth, height: headerHeight)
    }()
    
    var showNowPlayingClosure: (([Movie]) -> ())?
    var showPopularClosure: (([Movie]) -> ())?
    var showTopRatedClosure: (([Movie]) -> ())?
    var showUpComingClosure: (([Movie]) -> ())?
    
    init(dataServices: DataServices) {
        self.dataServices = dataServices
    }
    
    func fetchMovies() {
        loadNowPlayingMovies()
        loadPopularMovies()
        loadTopRatedMovies()
        loadUpcomingMovies()
    }
    
    func numberOfRows(collectionView: UICollectionView) -> Int {
        guard let moviesCollectionView = collectionView as? MoviesCollectionView else { return 0 }
        return moviesCollectionView.movies.count
    }
    
    private func loadNowPlayingMovies() {
        dataServices.getNowPlaying { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.nowPlayingMovies = movies
            self.showNowPlayingClosure?(self.nowPlayingMovies)
        }
    }
    
    private func loadPopularMovies() {
        dataServices.getPopular { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.popularMovies = movies
            self.showPopularClosure?(self.popularMovies)
        }
    }
    
    private func loadTopRatedMovies() {
        dataServices.getTopRated { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.topRatedMovies = movies
            self.showTopRatedClosure?(self.topRatedMovies)
        }
    }
    
    private func loadUpcomingMovies() {
        dataServices.getUpcoming { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.upComingMovies = movies
            self.showUpComingClosure?(self.upComingMovies)
        }
    }
}

struct MovieCellViewModel {
    let releaseDate: String
    let popularity: String
    let posterImageUrl: String
}
