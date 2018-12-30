//
//  TVDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class TVDetailsVC: UIViewController, HasCustomView {
    typealias CustomView = TVDetailsView
    
    var tvId: Int!
    var tvDetailsVM: (TVDetailsPresentable)!
    
    override func loadView() {
        let customView = TVDetailsView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        tvDetailsVM.displayDetails = { [unowned self] tvDetailsData in
            self.displayWith(tvDetailsData: tvDetailsData)
        }
        
        tvDetailsVM.fetchTVDetails()
    }
    
    private func displayWith(tvDetailsData: TVDetailsData) {
        self.customView.popularityLabel.text = tvDetailsData.popularity
        self.customView.countAverageLabel.text = tvDetailsData.countAverage
        self.customView.countLabel.text = tvDetailsData.count
        self.customView.titleLabel.text = tvDetailsData.originalName
        self.customView.genresLabel.text = tvDetailsData.genres
        self.customView.languagesLabel.text = tvDetailsData.language
        self.customView.noOfSeasonLabel.text = tvDetailsData.noOfSeasons
        self.customView.noOfEpisodesLabel.text = tvDetailsData.noOfEpisodes
        self.customView.runtimeLabel.text = tvDetailsData.runTimes
        self.customView.overviewLabel.text = tvDetailsData.overview
        self.customView.createdByLabel.text = tvDetailsData.createdBy
        self.customView.posterImageView.sd_setImage(with: URL(string: tvDetailsData.posterImageUrl), placeholderImage: UIImage(named: tvDetailsData.placeHolderImageName))
    }
}

extension TVDetailsVC: TVDetailsViewDelegate {
    func didTapCloseBtn() {
        self.tvDetailsVM.didTapCloseBtn()
    }
}
