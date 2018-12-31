//
//  MovieDetailsViewModel.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 29/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailsPresentable {
    var movieDetailsData: PublishSubject<MovieDetailsData> { get set }
    var closed: AnyObserver<Void>! { get set }
}

protocol MovieDetailsReactable {
    var closedTap: Observable<Void>! { get set }
}

class MovieDetailsViewModel: MovieDetailsPresentable, MovieDetailsReactable {
    var movieDetailsData = PublishSubject<MovieDetailsData>()
    var closed: AnyObserver<Void>!
    var closedTap: Observable<Void>! = PublishSubject<Void>()
    var didTapCloseBtnClosure: (() -> ())?
    
    private var dataServices: DataServices
    private var movieId: Int
    private var disposeBag: DisposeBag
    private var moviesHelper: MoviesHelper
    
    init(dataServices: DataServices, movieId: Int, moviesHelper: MoviesHelper, disposeBag: DisposeBag) {
        self.dataServices = dataServices
        self.movieId = movieId
        self.disposeBag = disposeBag
        self.moviesHelper = moviesHelper
        
        setupBinding()
        fetchMovieDetails()
    }
    
    private func parse(movie: Movie) -> MovieDetailsData {
        return moviesHelper.transform(movie: movie)
    }
    
    private func fetchMovieDetails() {
        dataServices.getMovieDetails(movieID: movieId)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (movie) in
                let movieDetails = self.parse(movie: movie)
                self.movieDetailsData.onNext(movieDetails)
            }, onError: { (error) in
                if error is ServiceError {
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupBinding() {
        let _closed = PublishSubject<Void>()
        self.closed = _closed.asObserver()
        self.closedTap = _closed.asObservable()
    }
}
