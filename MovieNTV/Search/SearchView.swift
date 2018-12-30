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
    func didSelectACell(indexPath: IndexPath)
}

class SearchView: UIView {
    weak var delegate: SearchViewDelegate?
    
    var searchVM: (SearchViewPresentable & SearchViewDelegate)!
    
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
        searchBar.barTintColor = .black
        return searchBar
    }()
    
    private var isShowingMovies = true
    private var resultMoviesArray = [Movie]()
    private var resultTVsArray = [TV]()
    
    lazy var resultView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
    
    func showResult(movies: [Movie], tvs: [TV]) {
        self.resultMoviesArray = movies
        self.resultTVsArray = tvs
        self.resultView.reloadData()
    }
}

extension SearchView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchVM.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchVM.numberOfitems(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return MovieCell() }
            cell.cleanUp4Reuse()
            let cellVM: MovieCellViewModel = searchVM.cellVM(indexPath: indexPath) as! MovieCellViewModel
            cell.setupWith(vm: cellVM)
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCell.identifier, for: indexPath) as? TVCell else { return TVCell() }
            let cellVM: TVCellVM = searchVM.cellVM(indexPath: indexPath) as! TVCellVM
            cell.cleanUp4Reuse()
            cell.setupWith(tvCellVM: cellVM)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchResultHeaderView.identifier, for: indexPath) as? SearchResultHeaderView else { return SearchResultHeaderView() }
        let headerStr = indexPath.section == 0 ? "Movies" : "TVs"
        headerView.updateWith(title: headerStr)
        return headerView
    }
}

// inherits UICollectionViewDelegate
// MARK: - UICollectionViewDelegate
// MARK: - UICollectionViewDelegateFlowLayout
extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return searchVM.headerSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectACell(indexPath: indexPath)
    }
}

// MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let keywords = searchBar.text
        self.delegate?.searchWith(words: keywords)
    }
}
