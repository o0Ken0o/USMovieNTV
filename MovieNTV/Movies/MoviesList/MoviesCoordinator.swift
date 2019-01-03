//
//  MoviesCoordinator.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MoviesCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let tabBarTag: Int
    private var moviesVC: MoviesVC!
    private let dataServices: DataServices = DataServices.shared
    private var movieDetailsCoordinator: MovieDetailsCoordinator?
    private var moviesVM: (MoviesViewPresentable & MoviesViewReactable)!
    private let disposeBag = DisposeBag()
    
    init(presenter: UINavigationController, tabBarTag:Int) {
        self.presenter = presenter
        self.tabBarTag = tabBarTag
    }
    
    func start() {
        self.moviesVC = MoviesVC()
        self.moviesVC.edgesForExtendedLayout = []
        self.moviesVC.title = "Movies"
        self.moviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "movie_icon"), tag: tabBarTag)
        
        self.moviesVM = MoviesViewModel(dataServices: dataServices, disposeBag: disposeBag)
        self.moviesVM.moviesHelper = MoviesHelper.shared
        self.moviesVC.moviesVM = self.moviesVM
        self.moviesVC.disposeBag = disposeBag
        
        self.presenter.pushViewController(moviesVC, animated: true)
        self.presenter.navigationBar.barTintColor = .black
        self.presenter.navigationBar.tintColor = .white
        self.presenter.navigationBar.isTranslucent = false
        self.presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.moviesVM.showMoviesTab
            .subscribe(onNext: { [unowned self] in
                self.showMoviesTab()
            })
            .disposed(by: disposeBag)
        
        self.moviesVM.goToMovieDetails
            .subscribe(onNext: { (movieId) in
                self.didSelect(movieId: movieId)
            })
            .disposed(by: disposeBag)
    }
    
    private func didSelect(movieId: Int) {
        self.movieDetailsCoordinator = MovieDetailsCoordinator(presenter: presenter, movieId: movieId)
        self.movieDetailsCoordinator?.start()
    }
    
    private func showMoviesTab() {
        // just a workaround to make the selected index 0
        self.presenter.tabBarController?.selectedIndex = 1
        self.presenter.tabBarController?.selectedIndex = 0
    }
}
