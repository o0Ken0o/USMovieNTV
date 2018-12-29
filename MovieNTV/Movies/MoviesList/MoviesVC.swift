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
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath)
    func viewIsLoaded()
}

class MoviesVC: UIViewController {
    
    weak var delegate: MoviesVCDelegate?
    var moviesVM: (MoviesViewPresentable & MoviesVCDelegate)!
    
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
    
    private lazy var nowPlayingCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.nowPlaying.rawValue)
    }()
    
    private lazy var popularCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.popular.rawValue)
    }()
    
    private lazy var topRelatedCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.topRated.rawValue)
    }()
    
    private lazy var upComingCollectionView: UICollectionView = {
        return self.createACollectionView(tag: MovieType.upComing.rawValue)
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0.08)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesVM.viewIsLoaded()
        
        addViews()
        setupConstraints()
        
        moviesVM.showNowPlayingClosure = { [weak self] in
            guard let self = self else { return }
            self.nowPlayingCollectionView.reloadData()
        }
        
        moviesVM.showPopularClosure = { [weak self] in
            guard let self = self else { return }
            self.popularCollectionView.reloadData()
        }
        
        moviesVM.showTopRatedClosure = { [weak self] in
            guard let self = self else { return }
            self.topRelatedCollectionView.reloadData()
        }
        
        moviesVM.showUpComingClosure = { [weak self] in
            guard let self = self else { return }
            self.upComingCollectionView.reloadData()
        }
        
        moviesVM.fetchMovies()
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
            make.height.equalTo(self.moviesVM.headerHeight)
        }
        
        self.popularLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nowPlayingCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(self.moviesVM.headerHeight)
        }
        
        self.topRelatedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(self.moviesVM.headerHeight)
        }
        
        self.upComingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedCollectionView.snp_bottomMargin)
            make.left.right.equalTo(self.nowPlayingLabel)
            make.height.equalTo(self.moviesVM.headerHeight)
        }
    }
    
    private func setupCollectionViewConstraints() {
        self.nowPlayingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nowPlayingLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesVM.itemHeight)
        }
        
        self.popularCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesVM.itemHeight)
        }
        
        self.topRelatedCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRelatedLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesVM.itemHeight)
        }
        
        self.upComingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.upComingLabel.snp_bottomMargin)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.moviesVM.itemHeight)
            make.bottom.equalTo(scrollView)
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
        layout.itemSize = self.moviesVM.itemSize
        
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
