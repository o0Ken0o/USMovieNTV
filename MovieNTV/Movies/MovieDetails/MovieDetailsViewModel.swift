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
}

protocol MovieDetailsReactable {
    var didTapCloseBtnClosure: (() -> ())? { get set }
}

class MovieDetailsViewModel: MovieDetailsPresentable, MovieDetailsReactable {
    var movieDetailsData: PublishSubject<MovieDetailsData> = PublishSubject<MovieDetailsData>()
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
}

extension MovieDetailsViewModel: MovieDetailsVCDelegate {
    func didTapCloseBtn() {
        self.didTapCloseBtnClosure?()
    }
}
