//
//  SearchView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
    func searchWith(words: String?)
}

class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
    
    // TODO: extract the following info into a viewModel
    private let cellSpacing: CGFloat = 3.0
    
    private lazy var itemSize: CGSize = {
        let width = UIScreen.main.bounds.size.width / 3 - cellSpacing
        let height = width * 1.3
        let size = CGSize(width: width, height: height)
        return size
    }()
    
    private lazy var searchBar: UISearchBar = { [unowned self] in
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private var isShowingMovies = true
    private var resultMoviesArray = [Movie]()
    private var resultTVsArray = [TV]()
    
    private lazy var resultView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MovieCell.classForCoder(), forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(TVCell.classForCoder(), forCellWithReuseIdentifier: TVCell.identifier)
        
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
    
    func showResult(movies: [Movie], tvs: [TV]) {
        self.resultMoviesArray = movies
        self.resultTVsArray = tvs
        self.resultView.reloadData()
    }
}

extension SearchView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return resultMoviesArray.count
        } else if section == 1 {
            return resultTVsArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return MovieCell() }
            cell.cleanUp4Reuse()
            cell.setupWith(movie: resultMoviesArray[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCell.identifier, for: indexPath) as? TVCell else { return TVCell() }
            cell.cleanUp4Reuse()
            cell.setupWith(tv: resultTVsArray[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension SearchView: UICollectionViewDelegate {
    
}

extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let keywords = searchBar.text
        self.delegate?.searchWith(words: keywords)
    }
}