//
//  TVsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVsVC: UIViewController, HasCustomView {
    typealias CustomView = TVsListView
    
    var vm: TVsPresentable!
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.airingTodayCollectionView.dataSource = self
        self.customView.airingTodayCollectionView.delegate = self
        
        self.customView.onTheAirCollectionView.dataSource = self
        self.customView.onTheAirCollectionView.delegate = self
        
        self.customView.popularCollectionView.dataSource = self
        self.customView.popularCollectionView.delegate = self
        
        self.customView.topRatedCollectionView.dataSource = self
        self.customView.topRatedCollectionView.delegate = self
        
        vm.showAiringToday = { [unowned self] in self.customView.showAiringToday() }
        vm.showOnTheAir = { [unowned self] in self.customView.showOnTheAir() }
        vm.showPopular = { [unowned self] in self.customView.showPopular() }
        vm.showTopRated = { [unowned self] in self.customView.showTopRated() }
        
        vm.fetchTVs()
    }
}

extension TVsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfItems(collectionView: collectionView, section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCell.identifier, for: indexPath) as? TVCell else {
            return TVCell()
        }
        
        let tvCellVM = vm.tvCellVM(collectionView: collectionView, indexPath: indexPath)
        cell.cleanUp4Reuse()
        cell.setupWith(tvCellVM: tvCellVM)
        
        return cell
    }
}

extension TVsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm.didSelect(collectionView: collectionView, indexPath: indexPath)
    }
}

extension TVsVC: TVsListViewDelegate {
    
}
