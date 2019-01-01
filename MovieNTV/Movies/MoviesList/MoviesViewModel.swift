//
//  MoviesViewModel.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 28/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol MoviesViewPresentable {
    var disposeBag: DisposeBag { get set }
    var nowPlayingMovies: BehaviorSubject<[MovieCellViewModel]> { get set }
    var showPopularClosure: (() -> ())? { get set }
    var showTopRatedClosure: (() -> ())? { get set }
    var showUpComingClosure: (() -> ())? { get set }
    var itemSize: CGSize { get }
    var headerSize: CGSize { get }
    var itemHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
    
    var moviesHelper: MoviesHelper! { get set }
    
    func fetchMovies()
    func numberOfRows(collectionView: UICollectionView) -> Int
    func movieCellVM(collectionView: UICollectionView, indexPath: IndexPath) -> MovieCellViewModel
    
    var didSelectAMovie: AnyObserver<MovieCellViewModel> { get set }
}

protocol MoviesViewReactable {
    var viewDidLoadClosure: (() ->())? { get set }
    var didSelectAMovieClosure: ((Movie) -> ())? { get set }
    var goToMovieDetails: Observable<Int> { get set }
}

class MoviesViewModel: MoviesViewPresentable, MoviesViewReactable {
    private let dataServices: DataServices
    var moviesHelper: MoviesHelper!
    
    var disposeBag: DisposeBag
    var nowPlayingMovies: BehaviorSubject<[MovieCellViewModel]>
    var didSelectAMovie: AnyObserver<MovieCellViewModel>
    var goToMovieDetails: Observable<Int>
    private var popularMovies = [Movie]()
    private var topRatedMovies = [Movie]()
    private var upComingMovies = [Movie]()
    
    private var nowPlayingMovieCellViewModels = [MovieCellViewModel]()
    private var popularMovieCellViewModels = [MovieCellViewModel]()
    private var topRatedMovieCellViewModels = [MovieCellViewModel]()
    private var upComingMovieCellViewModels = [MovieCellViewModel]()
    
    var showNowPlayingClosure: (() -> ())?
    var showPopularClosure: (() -> ())?
    var showTopRatedClosure: (() -> ())?
    var showUpComingClosure: (() -> ())?
    var viewDidLoadClosure: (() ->())?
    var didSelectAMovieClosure: ((Movie) -> ())?
    
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
    
    init(dataServices: DataServices, disposeBag: DisposeBag = DisposeBag()) {
        self.dataServices = dataServices
        self.disposeBag = disposeBag
        self.nowPlayingMovies = BehaviorSubject<[MovieCellViewModel]>(value: [])
        let _didSelectAMovie = PublishSubject<MovieCellViewModel>()
        self.didSelectAMovie = _didSelectAMovie.asObserver()
        self.goToMovieDetails = _didSelectAMovie.asObservable().map{ $0.movieId } 
    }
    
    func fetchMovies() {
        loadNowPlayingMovies()
        loadPopularMovies()
        loadTopRatedMovies()
        loadUpcomingMovies()
    }
    
    func numberOfRows(collectionView: UICollectionView) -> Int {
        guard let type = MovieType(rawValue: collectionView.tag) else { return 0 }
        
        switch type {
        case .nowPlaying:
            return nowPlayingMovieCellViewModels.count
        case .popular:
            return popularMovieCellViewModels.count
        case .topRated:
            return topRatedMovieCellViewModels.count
        case .upComing:
            return upComingMovieCellViewModels.count
        }
    }
    
    func didSelect(movie: Movie) {
        
    }
    
    func movieCellVM(collectionView: UICollectionView, indexPath: IndexPath) -> MovieCellViewModel {
        guard let type = MovieType(rawValue: collectionView.tag) else { return MovieCellViewModel(movieId: -1, releaseDate: "", popularity: "", posterImageUrl: "", placeHolderImageName: "") }
        
        switch type {
        case .nowPlaying:
            return nowPlayingMovieCellViewModels[indexPath.row]
        case .popular:
            return popularMovieCellViewModels[indexPath.row]
        case .topRated:
            return topRatedMovieCellViewModels[indexPath.row]
        case .upComing:
            return upComingMovieCellViewModels[indexPath.row]
        }
    }
    
    private func loadNowPlayingMovies() {
        dataServices.getNowPlayingObservable()
            .subscribe(onNext: { [unowned self] (movies) in
                self.nowPlayingMovieCellViewModels = movies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
                self.nowPlayingMovies.onNext(self.nowPlayingMovieCellViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadPopularMovies() {
        dataServices.getPopular { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.popularMovies = movies
            self.popularMovieCellViewModels = self.popularMovies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
            self.showPopularClosure?()
        }
    }
    
    private func loadTopRatedMovies() {
        dataServices.getTopRated { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.topRatedMovies = movies
            self.topRatedMovieCellViewModels = self.topRatedMovies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
            self.showTopRatedClosure?()
        }
    }
    
    private func loadUpcomingMovies() {
        dataServices.getUpcoming { [unowned self] (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.upComingMovies = movies
            self.upComingMovieCellViewModels = self.upComingMovies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
            self.showUpComingClosure?()
        }
    }
}

extension MoviesViewModel: MoviesVCDelegate {
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath) {
        guard let type = MovieType(rawValue: collectionView.tag) else { return }
        var movie: Movie!
        switch type {
        case .nowPlaying:
            break
        case .popular:
            movie = popularMovies[indexPath.row]
        case .topRated:
            movie = topRatedMovies[indexPath.row]
        case .upComing:
            movie = upComingMovies[indexPath.row]
        }
        self.didSelectAMovieClosure?(movie)
    }
    
    func viewIsLoaded() {
        self.viewDidLoadClosure?()
    }
}
