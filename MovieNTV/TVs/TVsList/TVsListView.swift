//
//  TVsListView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol TVsListViewDelegate: class {
    
}

class TVsListView: UIView {
    weak var delegate: TVsListViewDelegate?
    
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
    
    lazy var airingTodayLabel: UILabel = {
        return createAHeaderLabel(header: TVType.airingToday.header)
    }()
    
    lazy var onTheAirLabel: UILabel = {
        return createAHeaderLabel(header: TVType.onTheAir.header)
    }()
    
    lazy var popularLabel: UILabel = {
        return createAHeaderLabel(header: TVType.popular.header)
    }()
    
    lazy var topRatedLabel: UILabel = {
        return createAHeaderLabel(header: TVType.topRated.header)
    }()
    
    lazy var airingTodayCollectionView: UICollectionView = {
        return self.createACollectionView(tag: TVType.airingToday.rawValue)
    }()
    
    lazy var onTheAirCollectionView: UICollectionView = {
        return self.createACollectionView(tag: TVType.onTheAir.rawValue)
    }()
    
    lazy var popularCollectionView: UICollectionView = {
        return self.createACollectionView(tag: TVType.popular.rawValue)
    }()
    
    lazy var topRatedCollectionView: UICollectionView = {
        return self.createACollectionView(tag: TVType.topRated.rawValue)
    }()
    
    lazy var scrollView: UIScrollView = { [unowned self] in
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
    
    func showAiringToday() {
        self.airingTodayCollectionView.reloadData()
    }
    
    func showOnTheAir() {
        self.onTheAirCollectionView.reloadData()
    }
    
    func showPopular() {
        self.popularCollectionView.reloadData()
    }
    
    func showTopRated() {
        self.topRatedCollectionView.reloadData()
    }
    
    private func addViews() {
        self.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.airingTodayLabel)
        self.scrollView.addSubview(self.onTheAirLabel)
        self.scrollView.addSubview(self.popularLabel)
        self.scrollView.addSubview(self.topRatedLabel)
        
        self.scrollView.addSubview(self.airingTodayCollectionView)
        self.scrollView.addSubview(self.onTheAirCollectionView)
        self.scrollView.addSubview(self.popularCollectionView)
        self.scrollView.addSubview(self.topRatedCollectionView)
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
        self.airingTodayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self)
            make.height.equalTo(headerSize.height)
        }
        
        self.onTheAirLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.airingTodayCollectionView.snp.bottomMargin)
            make.left.right.equalTo(self.airingTodayLabel)
            make.height.equalTo(headerSize.height)
        }
        
        self.popularLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.onTheAirCollectionView.snp.bottomMargin)
            make.left.right.equalTo(self.airingTodayLabel)
            make.height.equalTo(headerSize.height)
        }
        
        self.topRatedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularCollectionView.snp.bottomMargin)
            make.left.right.equalTo(self.airingTodayLabel)
            make.height.equalTo(headerSize.height)
        }
    }
    
    private func setupCollectionViewConstraints() {
        self.airingTodayCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.airingTodayLabel.snp.bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
        }
        
        self.onTheAirCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.onTheAirLabel.snp.bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
        }
        
        self.popularCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularLabel.snp.bottomMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(itemSize.height)
        }
        
        self.topRatedCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topRatedLabel.snp.bottomMargin)
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
    
    private func createACollectionView(tag: Int) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = tag
        collectionView.register(TVCell.classForCoder(), forCellWithReuseIdentifier: TVCell.identifier)
        
        return collectionView
    }
}
