//
//  MoviesVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SnapKit

protocol MoviesVCDelegate: class {
    func didSelect(movie: Movie)
    func viewIsLoaded()
}

class MoviesVC: UIViewController {
    
    weak var delegate: MoviesVCDelegate?
    var moviesViewPresentable: MoviesViewPresentable!
    
    private lazy var nowPlayingLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.nowPlaying.header)
    }()
    
    private lazy var popularLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.popular.header)
    }()
    
    private lazy var topRelatedLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.topRated.header)
    }()
    
    private lazy var upComingLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.upComing.header)
    }()
    
    private lazy var nowPlayingCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var popularCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var topRelatedCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var upComingCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0.08)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.viewIsLoaded()
        
        addViews()
        setupConstraints()
        
        moviesViewPresentable.showNowPlayingClosure = { [weak self] movies in
            guard let self = self else { return }
            self.showNowPlaying(movies: movies)
        }
        
        moviesViewPresentable.showPopularClosure = { [weak self] movies in
            guard let self = self else { return }
            self.showPopular(movies: movies)
        }
        
        moviesViewPresentable.showTopRatedClosure = { [weak self] movies in
            guard let self = self else { return }
            self.showTopRated(movies: movies)
        }
        
        moviesViewPresentable.showUpComingClosure = { [weak self] movies in
            guard let self = self else { return }
            self.showUpcoming(movies: movies)
        }
        
        moviesViewPresentable.fetchMovies()
    }
    
    private func showNowPlaying(movies: [Movie]) {
        self.nowPlayingCollectionView.movies = movies
        self.nowPlayingCollectionView.reloadData()
    }
    
    private func showPopular(movies: [Movie]) {
        self.popularCollectionView.movies = movies
        self.popularCollectionView.reloadData()
    }
    
    private func showTopRated(movies: [Movie]) {
        self.topRelatedCollectionView.movies = movies
        self.topRelatedCollectionView.reloadData()
    }
    
    private func showUpcoming(movies: [Movie]) {
        self.upComingCollectionView.movies = movies
        self.upComingCollectionView.reloadData()
    }
    
    private func addViews() {
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.nowPlayingLabel)
        self.scrollView.addSubview(self.popularLabel)
        self.scrollView.addSubview(self.topRelatedLabel)
        self.scrollView.addSubview(self.upComingLabel)
        
        self.scrollView.addSubview(self.nowPlayingCollectionView)
        self.scrollView.addSubview(self.popularCollectionView)
        self.scrollView.addSubview(self.topRelatedCollectionView)
        self.scrollView.addSubview(self.upComingCollectionView)
    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupHeaderLabelsConstraints()
        setupCollectionViewConstraints()
    }
    
    private func setupScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.view)
        }
    }
    
    private func setupHeaderLabelsConstraints() {
        self.nowPlayingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view)
            make.height.equalTo(self.moviesViewPresentable.headerHeight)
        }
        
        self.popularLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nowPlayingCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(self.moviesViewPresentable.headerHeight)
        }
        
        self.topRelatedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(self.moviesViewPresentable.headerHeight)
        }
        
        self.upComingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(self.moviesViewPresentable.headerHeight)
        }
    }
    
    private func setupCollectionViewConstraints() {
        self.nowPlayingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nowPlayingLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesViewPresentable.itemHeight)
        }
        
        self.popularCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesViewPresentable.itemHeight)
        }
        
        self.topRelatedCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesViewPresentable.itemHeight)
        }
        
        self.upComingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.upComingLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesViewPresentable.itemHeight)
            make.bottom.equalTo(scrollView)
        }
    }
    
    private func createAHeaderLabel(header: String) -> UILabel {
        let label = UILabel()
        label.text = header
        label.textColor = .white
        return label
    }
    
    private func createACollectionView() -> MoviesCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = self.moviesViewPresentable.itemSize
        
        let collectionView = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.classForCoder(), forCellWithReuseIdentifier: MovieCell.identifier)
        
        return collectionView
    }
}

extension MoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewPresentable.numberOfRows(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let moviesCollectionView = collectionView as? MoviesCollectionView,
            let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                return MovieCell()
        }
        
        cell.cleanUp4Reuse()
        cell.setupWith(movie: moviesCollectionView.movies[indexPath.row])
        
        return cell
    }
}

extension MoviesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let moviesCollectionView = collectionView as? MoviesCollectionView else { return }
        self.delegate?.didSelect(movie: moviesCollectionView.movies[indexPath.row])
    }
}
