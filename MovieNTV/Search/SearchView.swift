//
//  SearchView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class SearchView: UIView {
    var searchVM: SearchViewPresentable!
    
    private lazy var itemSize: CGSize = {
        let width = UIScreen.main.bounds.size.width / 3 - searchVM.cellSpacing
        let height = width * 1.3
        let size = CGSize(width: width, height: height)
        return size
    }()
    
    lazy var searchBar: UISearchBar = { [unowned self] in
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        return searchBar
    }()
    
    lazy var resultView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = searchVM.cellSpacing
        layout.minimumLineSpacing = searchVM.cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MovieCell.classForCoder(), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(TVCell.classForCoder(), forCellWithReuseIdentifier: TVCell.identifier)
        collectionView.register(SearchResultHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderView.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(searchBar)
        self.addSubview(resultView)
    }
    
    private func setupConstraints() {
        setupSearchBarConstraints()
        setupSearchResultViewConstraints()
    }
    
    private func setupSearchBarConstraints() {
        searchBar.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            } else {
                make.top.left.right.equalTo(self)
            }
        }
    }
    
    private func setupSearchResultViewConstraints() {
        resultView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.equalTo(self)
            if #available(iOS 11, *) {
                make.bottom.equalTo(self.safeAreaLayoutGuide)
            } else {
                make.bottom.equalTo(self)
            }
        }
    }
}
