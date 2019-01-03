//
//  MoviesVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MoviesVC: UIViewController, HasCustomView {
    typealias CustomView = MoviesListView
    var moviesVM: (MoviesViewPresentable)!
    var disposeBag: DisposeBag!
    
    override func loadView() {
        let customView = CustomView()
        customView.moviesVM = moviesVM
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        
        Observable<Void>.just(())
            .bind(to: self.moviesVM.viewIsLoaded)
            .disposed(by: disposeBag)
        
        bind(collectionView: self.customView.nowPlayingCollectionView, moviesObserver: moviesVM.nowPlayingMovies)
        bind(collectionView: self.customView.popularCollectionView, moviesObserver: moviesVM.popularMovies)
        bind(collectionView: self.customView.topRelatedCollectionView, moviesObserver: moviesVM.topRatedMovies)
        bind(collectionView: self.customView.upComingCollectionView, moviesObserver: moviesVM.upComingMovies)
    }
    
    private func bind(collectionView: UICollectionView, moviesObserver: BehaviorSubject<[MovieCellViewModel]>) {
        moviesObserver.asObservable()
            .bind(to: collectionView.rx.items) { (collectionView, row, movieCellVM) in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                    return MovieCell()
                }
                cell.cleanUp4Reuse()
                cell.setupWith(vm: movieCellVM)
                return cell
            }
            .disposed(by: disposeBag)
        
        collectionView.rx
            .modelSelected(MovieCellViewModel.self)
            .bind(to: self.moviesVM.didSelectAMovie)
            .disposed(by: disposeBag)
    }
}
