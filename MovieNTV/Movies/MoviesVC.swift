//
//  MoviesVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SnapKit

class MoviesVC: UIViewController {
    // TODO: extract the following info into a viewModel
    fileprivate let itemSize: CGSize = {
        let width = UIScreen.main.bounds.size.width / 3
        let height = width * 1.3
        let size = CGSize(width: width, height: height)
        return size
    }()
    
    fileprivate let headerSize: CGSize = {
        let width = UIScreen.main.bounds.size.width / 3
        let height = CGFloat(60.0)
        let size = CGSize(width: width, height: height)
        return size
    }()
    
    lazy var nowPlayingLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.nowPlaying.header)
    }()
    
    lazy var popularLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.popular.header)
    }()
    
    lazy var topRelatedLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.topRated.header)
    }()
    
    lazy var upComingLabel: UILabel = {
        return createAHeaderLabel(header: MovieType.upComing.header)
    }()
    
    lazy var nowPlayingCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    lazy var popularCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    lazy var topRelatedCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    lazy var upComingCollectionView: MoviesCollectionView = {
        return self.createACollectionView()
    }()
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0.08)
        scrollView.contentSize = self.view.frame.size
        return scrollView
    }()
    
    var dataServices: DataServices!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        
        setupConstraints()
        
        loadNowPlayingMovies()
        loadPopularMovies()
        loadTopRatedMovies()
        loadUpcomingMovies()
    }
    
    private func loadNowPlayingMovies() {
        dataServices.getNowPlaying { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.nowPlayingCollectionView.movies = movies
            self.nowPlayingCollectionView.reloadData()
        }
    }
    
    private func loadPopularMovies() {
        dataServices.getPopular { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.popularCollectionView.movies = movies
            self.popularCollectionView.reloadData()
        }
    }
    
    private func loadTopRatedMovies() {
        dataServices.getTopRated { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.topRelatedCollectionView.movies = movies
            self.topRelatedCollectionView.reloadData()
        }
    }
    
    private func loadUpcomingMovies() {
        dataServices.getUpcoming { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.upComingCollectionView.movies = movies
            self.upComingCollectionView.reloadData()
        }
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
            make.left.right.equalTo(self.view)
            make.height.equalTo(itemSize.height)
        }
        
        self.popularCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(itemSize.height)
        }
        
        self.topRelatedCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(itemSize.height)
        }
        
        self.upComingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.upComingLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(itemSize.height)
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

extension MoviesVC: UICollectionViewDataSource {
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

extension MoviesVC: UICollectionViewDelegate {
    
}
