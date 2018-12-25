//
//  TVsListView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol TVsListViewDelegate: class {
    func didSelect(tv: TV)
}

class TVsListView: UIView {
    weak var delegate: TVsListViewDelegate?
    
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
    
    private lazy var airingTodayLabel: UILabel = {
        return createAHeaderLabel(header: TVType.airingToday.header)
    }()
    
    private lazy var onTheAirLabel: UILabel = {
        return createAHeaderLabel(header: TVType.onTheAir.header)
    }()
    
    private lazy var popularLabel: UILabel = {
        return createAHeaderLabel(header: TVType.popular.header)
    }()
    
    private lazy var topRatedLabel: UILabel = {
        return createAHeaderLabel(header: TVType.topRated.header)
    }()
    
    private lazy var airingTodayCollectionView: TVsCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var onTheAirCollectionView: TVsCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var popularCollectionView: TVsCollectionView = {
        return self.createACollectionView()
    }()
    
    private lazy var topRatedCollectionView: TVsCollectionView = {
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
    
    func showAiringToday(tvs: [TV]) {
        self.airingTodayCollectionView.tvs = tvs
        self.airingTodayCollectionView.reloadData()
    }
    
    func showOnTheAir(tvs: [TV]) {
        self.onTheAirCollectionView.tvs = tvs
        self.onTheAirCollectionView.reloadData()
    }
    
    func showPopular(tvs: [TV]) {
        self.popularCollectionView.tvs = tvs
        self.popularCollectionView.reloadData()
    }
    
    func showTopRated(tvs: [TV]) {
        self.topRatedCollectionView.tvs = tvs
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
    
    private func createACollectionView() -> TVsCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
        
        let collectionView = TVsCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TVCell.classForCoder(), forCellWithReuseIdentifier: TVCell.identifier)
        
        return collectionView
    }
}

extension TVsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tvsCollectionView = collectionView as? TVsCollectionView else { return 0 }
        return tvsCollectionView.tvs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tvsCollectionView = collectionView as? TVsCollectionView,
            let cell = tvsCollectionView.dequeueReusableCell(withReuseIdentifier: TVCell.identifier, for: indexPath) as? TVCell else {
                return TVCell()
        }
        
        cell.cleanUp4Reuse()
        cell.setupWith(tv: tvsCollectionView.tvs[indexPath.row])
        
        return cell
    }
}

extension TVsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvsCollectionView = collectionView as? TVsCollectionView else { return }
        self.delegate?.didSelect(tv: tvsCollectionView.tvs[indexPath.row])
    }
}
