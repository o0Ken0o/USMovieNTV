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

protocol MoviesVCDelegate: class {
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath)
    func viewIsLoaded()
}

class MoviesVC: UIViewController, HasCustomView {
    typealias CustomView = MoviesListView
    weak var delegate: MoviesVCDelegate?
    var moviesVM: (MoviesViewPresentable & MoviesVCDelegate)!
    var disposeBag: DisposeBag!
    
    override func loadView() {
        let customView = CustomView()
        customView.moviesVM = moviesVM
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesVM.viewIsLoaded()
        
        self.customView.popularCollectionView.dataSource = self
        self.customView.popularCollectionView.delegate = self
        self.customView.topRelatedCollectionView.dataSource = self
        self.customView.topRelatedCollectionView.delegate = self
        self.customView.upComingCollectionView.dataSource = self
        self.customView.upComingCollectionView.delegate = self
        
        moviesVM.nowPlayingMovies
            .asObservable()
            .bind(to: self.customView.nowPlayingCollectionView.rx.items) { (collectionView, row, movieCellVM) in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                    return MovieCell()
                }
                cell.cleanUp4Reuse()
                cell.setupWith(vm: movieCellVM)
                return cell
            }
            .disposed(by: disposeBag)
        
        self.customView.nowPlayingCollectionView.rx
            .modelSelected(MovieCellViewModel.self)
            .bind(to: self.moviesVM.didSelectAMovie)
            .disposed(by: disposeBag)
        
        moviesVM.showPopularClosure = { [weak self] in
            guard let self = self else { return }
            self.customView.popularCollectionView.reloadData()
        }
        
        moviesVM.showTopRatedClosure = { [weak self] in
            guard let self = self else { return }
            self.customView.topRelatedCollectionView.reloadData()
        }
        
        moviesVM.showUpComingClosure = { [weak self] in
            guard let self = self else { return }
            self.customView.upComingCollectionView.reloadData()
        }
        
        moviesVM.fetchMovies()
    }
}

extension MoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesVM.numberOfRows(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                return MovieCell()
        }
        
        cell.cleanUp4Reuse()
        cell.setupWith(vm: moviesVM.movieCellVM(collectionView: collectionView, indexPath: indexPath))
        
        return cell
    }
}

extension MoviesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moviesVM.didSelect(collectionView: collectionView, indexPath: indexPath)
    }
}
