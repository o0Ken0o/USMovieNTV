//
//  SearchVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol SearchVCDelegate: class {
    func searchWith(words: String?)
    func didSelectACell(indexPath: IndexPath)
}

class SearchVC: UIViewController, HasCustomView {
    typealias CustomView = SearchView
    
    weak var delegate: SearchVCDelegate?
    var searchVM: (SearchViewPresentable & SearchVCDelegate)!
    
    override func loadView() {
        let customView = CustomView()
        customView.searchVM = searchVM
        customView.resultView.dataSource = self
        customView.resultView.delegate = self
        customView.searchBar.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVM.showSearchResults = { [unowned self] in
            self.customView.resultView.reloadData()
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
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
        headerView.updateWith(title: searchVM.headerString(indexPath: indexPath))
        return headerView
    }
}

// inherits UICollectionViewDelegate
// MARK: - UICollectionViewDelegate
// MARK: - UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return searchVM.headerSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectACell(indexPath: indexPath)
    }
}

// MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let keywords = searchBar.text
        self.delegate?.searchWith(words: keywords)
    }
}
