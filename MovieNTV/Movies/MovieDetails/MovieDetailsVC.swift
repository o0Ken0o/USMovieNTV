//
//  MovieDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController, HasCustomView {
    
    typealias CustomView = MovieDetailsView
    
    var movieDetailsVM: MovieDetailsPresentable!
    
    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        movieDetailsVM.displayDetails = { [unowned self] in
            self.displayWith(vm: self.movieDetailsVM)
        }
        
        movieDetailsVM.fetchMovieDetails()
    }
    
    private func displayWith(vm: MovieDetailsPresentable) {
        self.customView.posterImageView.sd_setImage(with: URL(string: vm.posterImageUrl), placeholderImage: UIImage(named: vm.placeHolderImageName))
        self.customView.popularityLabel.text = vm.popularity
        self.customView.countLabel.text = vm.count
        self.customView.titleLabel.text = vm.title
        self.customView.genresLabel.text = vm.genres
        self.customView.languagesLabel.text = vm.spokenLanguages
        self.customView.companiesLabel.text = vm.productionCompanies
        self.customView.countriesLabel.text = vm.productionCountries
        self.customView.releaseDateLabel.text = vm.releaseDate
        self.customView.runtimeLabel.text = vm.runTimeMins
    }
}

extension MovieDetailsVC: MovieDetailsViewDelegate {
    func didTapCloseBtn() {
        self.dismiss(animated: true)
    }
}
