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
    var popularMovies: BehaviorSubject<[MovieCellViewModel]> { get set }
    var topRatedMovies: BehaviorSubject<[MovieCellViewModel]> { get set }
    var upComingMovies: BehaviorSubject<[MovieCellViewModel]> { get set }

    var itemSize: CGSize { get }
    var headerSize: CGSize { get }
    var itemHeight: CGFloat { get }
    var headerHeight: CGFloat { get }
    
    var moviesHelper: MoviesHelper! { get set }
    var didSelectAMovie: AnyObserver<MovieCellViewModel> { get set }
    var viewIsLoaded: AnyObserver<Void> { get set }
}

protocol MoviesViewReactable {
    var showMoviesTab: Observable<Void> { get set }
    var goToMovieDetails: Observable<Int> { get set }
}

class MoviesViewModel: MoviesViewPresentable, MoviesViewReactable {
    private let dataServices: DataServices
    var moviesHelper: MoviesHelper!
    
    var disposeBag: DisposeBag
    var nowPlayingMovies: BehaviorSubject<[MovieCellViewModel]>
    var popularMovies: BehaviorSubject<[MovieCellViewModel]>
    var topRatedMovies: BehaviorSubject<[MovieCellViewModel]>
    var upComingMovies: BehaviorSubject<[MovieCellViewModel]>
    
    var didSelectAMovie: AnyObserver<MovieCellViewModel>
    var goToMovieDetails: Observable<Int>
    
    var viewIsLoaded: AnyObserver<Void>
    var showMoviesTab: Observable<Void>
    
    private var nowPlayingMovieCellViewModels = [MovieCellViewModel]()
    private var popularMovieCellViewModels = [MovieCellViewModel]()
    private var topRatedMovieCellViewModels = [MovieCellViewModel]()
    private var upComingMovieCellViewModels = [MovieCellViewModel]()
 
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
        self.popularMovies = BehaviorSubject<[MovieCellViewModel]>(value: [])
        self.topRatedMovies = BehaviorSubject<[MovieCellViewModel]>(value: [])
        self.upComingMovies = BehaviorSubject<[MovieCellViewModel]>(value: [])
        
        let _didSelectAMovie = PublishSubject<MovieCellViewModel>()
        self.didSelectAMovie = _didSelectAMovie.asObserver()
        self.goToMovieDetails = _didSelectAMovie.asObservable().map{ $0.movieId }
        
        let _viewLoaded = PublishSubject<Void>()
        self.viewIsLoaded = _viewLoaded.asObserver()
        self.showMoviesTab = _viewLoaded.asObservable()
        
        fetchMovies()
    }
    
    func fetchMovies() {
        loadNowPlayingMovies()
        loadPopularMovies()
        loadTopRatedMovies()
        loadUpcomingMovies()
    }

    private func loadNowPlayingMovies() {
        dataServices.getNowPlaying()
            .subscribe(onNext: { [unowned self] (movies) in
                self.nowPlayingMovieCellViewModels = movies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
                self.nowPlayingMovies.onNext(self.nowPlayingMovieCellViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadPopularMovies() {
        dataServices.getPopular()
            .subscribe(onNext: { [unowned self] (movies) in
                self.popularMovieCellViewModels = movies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
                self.popularMovies.onNext(self.popularMovieCellViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadTopRatedMovies() {
        dataServices.getTopRated()
            .subscribe(onNext: { [unowned self] (movies) in
                self.topRatedMovieCellViewModels = movies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
                self.topRatedMovies.onNext(self.topRatedMovieCellViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadUpcomingMovies() {
        dataServices.getUpcoming()
            .subscribe(onNext: { [unowned self] (movies) in
                self.upComingMovieCellViewModels = movies.map{ [unowned self] in self.moviesHelper.transfrom(movie: $0) }
                self.upComingMovies.onNext(self.upComingMovieCellViewModels)
            })
            .disposed(by: disposeBag)
    }
}
