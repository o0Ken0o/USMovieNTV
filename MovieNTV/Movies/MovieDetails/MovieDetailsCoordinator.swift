//
//  MovieDetailsCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsCoordinator: BaseCoordinator {
    
    private let presenter: UINavigationController
    private var movieDetailsVC: MovieDetailsVC!
    private var movieDetailsVM: (MovieDetailsPresentable & MovieDetailsReactable)!
    private let dataServices: DataServices = DataServices.shared
    private let movie: Movie
    private let disposeBag = DisposeBag()
    
    init(presenter: UINavigationController, movie: Movie) {
        self.presenter = presenter
        self.movie = movie
    }
    
    func start() {
        self.movieDetailsVM = MovieDetailsViewModel(dataServices: dataServices, movieId: movie.id, moviesHelper: MoviesHelper.shared, disposeBag: disposeBag)
        
        self.movieDetailsVC = MovieDetailsVC()
        self.movieDetailsVC.movieDetailsVM = self.movieDetailsVM
        
        self.movieDetailsVM.closedTap
            .subscribe(onNext: { [unowned self] in self.didTapCloseBtn()})
            .disposed(by: disposeBag)
        
        self.presenter.present(movieDetailsVC, animated: true)
    }
    
    private func didTapCloseBtn() {
        self.movieDetailsVC.dismiss(animated: true)
    }
}
