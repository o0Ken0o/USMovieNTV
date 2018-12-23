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
    
    lazy var nowPlayingCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.nowPlaying.rawValue)
    }()
    
    lazy var popularCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.popular.rawValue)
    }()
    
    lazy var topRelatedCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.topRated.rawValue)
    }()
    
    lazy var upComingCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.upComing.rawValue)
    }()
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        scrollView.contentSize = self.view.frame.size
        return scrollView
    }()
    
    var dataServices: DataServices!
    var nowPlayingMovies = [Movie]()
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var upComingMovies = [Movie]()
    
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
            
            self.nowPlayingMovies = movies
            self.nowPlayingCollectionView.reloadData()
        }
    }
    
    private func loadPopularMovies() {
        dataServices.getPopular { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.popularMovies = movies
            self.popularCollectionView.reloadData()
        }
    }
    
    private func loadTopRatedMovies() {
        dataServices.getTopRated { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.topRatedMovies = movies
            self.topRelatedCollectionView.reloadData()
        }
    }
    
    private func loadUpcomingMovies() {
        dataServices.getUpcoming { (success, movies) in
            guard success, let movies = movies else {
                return
            }
            
            self.upComingMovies = movies
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
    
    private func createACollectionView(tag: Int) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = tag
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.classForCoder(), forCellWithReuseIdentifier: MovieCell.identifier)
        
        return collectionView
    }
}

extension MoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movieType = MovieType(rawValue: collectionView.tag) else { return 0 }
        
        var count = 0
        
        switch movieType {
        case .nowPlaying:
            count = nowPlayingMovies.count
            
        case .popular:
            count = popularMovies.count
            
        case .topRated:
            count = topRatedMovies.count
            
        case .upComing:
            count = upComingMovies.count
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell,
            let movieType = MovieType(rawValue: collectionView.tag) else { return MovieCell() }
        
        var movies = [Movie]()
        
        switch movieType {
        case .nowPlaying:
            movies = nowPlayingMovies
            
        case .popular:
            movies = popularMovies
            
        case .topRated:
            movies = topRatedMovies
            
        case .upComing:
            movies = upComingMovies
        }
        
        cell.cleanUp4Reuse()
        cell.setupWith(movie: movies[indexPath.row])
        
        return cell
    }
}

extension MoviesVC: UICollectionViewDelegate {
    
}
