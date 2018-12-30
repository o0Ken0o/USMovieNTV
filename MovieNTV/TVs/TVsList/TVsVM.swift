//
//  TVsVM.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 29/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol TVsPresentable {
    var dataServices: DataServices! { get set }
    var tvsHelper: TVsHelper! { get set }
    var showAiringToday: (() -> ())? { get set }
    var showOnTheAir: (() -> ())? { get set }
    var showPopular: (() -> ())? { get set }
    var showTopRated: (() -> ())? { get set }
    
    func fetchTVs()
    func numberOfItems(collectionView: UICollectionView, section: Int) -> Int
    func tvCellVM(collectionView: UICollectionView, indexPath: IndexPath) -> TVCellVM
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath)
}

protocol TVsReactable {
    var didSelectATV: ((TV) -> ())? { get set }
}

class TVsVM: TVsPresentable, TVsReactable {
    var dataServices: DataServices!
    var tvsHelper: TVsHelper!
    
    private var airingTVs = [TV]()
    private var onTheAirTVs = [TV]()
    private var popularTVs = [TV]()
    private var topRatedTVs = [TV]()
    
    private var airingTVCellVMs = [TVCellVM]()
    private var onTheAirTVCellVMs = [TVCellVM]()
    private var popularTVCellVMs = [TVCellVM]()
    private var topRatedTVCellVMs = [TVCellVM]()
    
    var showAiringToday: (() -> ())?
    var showOnTheAir: (() -> ())?
    var showPopular: (() -> ())?
    var showTopRated: (() -> ())?
    
    var didSelectATV: ((TV) -> ())?
    
    func fetchTVs() {
        loadAiringToday()
        loadOnTheAir()
        loadPopular()
        loadTopRated()
    }
    
    func numberOfItems(collectionView: UICollectionView, section: Int) -> Int {
        guard let type = TVType(rawValue: collectionView.tag) else { return 0 }
        switch type {
        case .airingToday:
            return airingTVCellVMs.count
        case .onTheAir:
            return onTheAirTVCellVMs.count
        case .popular:
            return popularTVCellVMs.count
        case .topRated:
            return topRatedTVCellVMs.count
        }
    }
    
    func tvCellVM(collectionView: UICollectionView, indexPath: IndexPath) -> TVCellVM {
        guard let type = TVType(rawValue: collectionView.tag) else { return TVCellVM(releaseDate: "", popularity: "", posterImageUrl: "", placeHolderImageName: "") }
        switch type {
        case .airingToday:
            return airingTVCellVMs[indexPath.row]
        case .onTheAir:
            return onTheAirTVCellVMs[indexPath.row]
        case .popular:
            return popularTVCellVMs[indexPath.row]
        case .topRated:
            return topRatedTVCellVMs[indexPath.row]
        }
    }
    
    func didSelect(collectionView: UICollectionView, indexPath: IndexPath) {
        guard let type = TVType(rawValue: collectionView.tag) else { return }
        
        var tv: TV!
        switch type {
        case .airingToday:
            tv = airingTVs[indexPath.row]
        case .onTheAir:
            tv = onTheAirTVs[indexPath.row]
        case .popular:
            tv = popularTVs[indexPath.row]
        case .topRated:
            tv = topRatedTVs[indexPath.row]
        }
        
        self.didSelectATV?(tv)
    }
    
    private func loadAiringToday() {
        dataServices.getAiringToday { [unowned self] (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.airingTVs = tvs
            self.airingTVCellVMs = self.airingTVs.map{ [unowned self] in self.tvsHelper.tranform(tv: $0) }
            self.showAiringToday?()
        }
    }
    
    private func loadOnTheAir() {
        dataServices.getTVOnTheAir { [unowned self] (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.onTheAirTVs = tvs
            self.onTheAirTVCellVMs = self.onTheAirTVs.map{ [unowned self] in self.tvsHelper.tranform(tv: $0) }
            self.showOnTheAir?()
        }
    }
    
    private func loadPopular() {
        dataServices.getTVPopular { [unowned self] (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.popularTVs = tvs
            self.popularTVCellVMs = self.popularTVs.map{ [unowned self] in self.tvsHelper.tranform(tv: $0) }
            self.showPopular?()
        }
    }
    
    private func loadTopRated() {
        dataServices.getTVTopRated { [unowned self] (success, tvs) in
            guard success, let tvs = tvs else { return }
            self.topRatedTVs = tvs
            self.topRatedTVCellVMs = self.topRatedTVs.map{ [unowned self] in self.tvsHelper.tranform(tv: $0) }
            self.showTopRated?()
        }
    }
}
