//
//  MoviesListView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol MoviesListViewDelegate: class {
    func didSelect(movie: Movie)
}

class MoviesListView: UIView {
    weak var delegate: MoviesListViewDelegate?
    
    // TODO: extract the following info into a viewModel
    private let itemSize: CGSize = {
        let width = UIScreen.main.bounds.size.width / 3
        let height = width * 1.3
        let size = CGSize(width: width, height: height)
        return size
    }()
    
    private let headerSize: CGSize = {
        let width = UIScreen.main.bounds.size.width / 3
        let height = CGFloat(60.0)
        let size = CGSize(width: width, height: height)
        return size
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showNowPlaying(movies: [Movie]) {
        self.nowPlayingCollectionView.movies = movies
        self.nowPlayingCollectionView.reloadData()
    }
    
    func showPopular(movies: [Movie]) {
        self.popularCollectionView.movies = movies
        self.popularCollectionView.reloadData()
    }
    
    func showTopRated(movies: [Movie]) {
        self.topRelatedCollectionView.movies = movies
        self.topRelatedCollectionView.reloadData()
    }
    
    func showUpcoming(movies: [Movie]) {
        self.upComingCollectionView.movies = movies
        self.upComingCollectionView.reloadData()
    }
    
    private func addViews() {
        self.addSubview(self.scrollView)
        
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
            make.top.bottom.left.right.equalTo(self)
        }
    }
    
    private func setupHeaderLabelsConstraints() {
        self.nowPlayingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self)
            make.height.equalTo(headerSize.height)
        }
        
        self.popularLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nowPlayingCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(headerSize.height)
        }
        
        self.topRelatedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(headerSize.height)
        }
        
        self.upComingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(headerSize.height)
        }
    }
    
    private func setupCollectionViewConstraints() {
        self.nowPlayingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nowPlayingLabel.snp_bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
        }
        
        self.popularCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularLabel.snp_bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
        }
        
        self.topRelatedCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedLabel.snp_bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
        }
        
        self.upComingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.upComingLabel.snp_bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
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
        layout.itemSize = itemSize
        
        let collectionView = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.classForCoder(), forCellWithReuseIdentifier: MovieCell.identifier)
        
        return collectionView
    }
}

extension MoviesListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let moviesCollectionView = collectionView as? MoviesCollectionView else { return 0 }
        return moviesCollectionView.movies.count
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

extension MoviesListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let moviesCollectionView = collectionView as? MoviesCollectionView else { return }
        self.delegate?.didSelect(movie: moviesCollectionView.movies[indexPath.row])
    }
}
