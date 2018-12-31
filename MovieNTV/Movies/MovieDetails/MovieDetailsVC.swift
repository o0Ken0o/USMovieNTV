//
//  MovieDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsVC: UIViewController, HasCustomView {
    
    typealias CustomView = MovieDetailsView
    var movieDetailsVM: MovieDetailsPresentable!
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        let customView = CustomView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        movieDetailsVM.movieDetailsData
            .subscribe(onNext: { [unowned self] in self.displayWith(movieDetails: $0) })
            .disposed(by: disposeBag)
        
        self.customView.closeBtn.rx.tap
            .bind(to: movieDetailsVM.closed)
            .disposed(by: disposeBag)
    }
    
    private func displayWith(movieDetails: MovieDetailsData) {
        self.customView.posterImageView.sd_setImage(with: URL(string: movieDetails.posterImageUrl), placeholderImage: UIImage(named: movieDetails.placeHolderImageName))
        self.customView.popularityLabel.text = movieDetails.popularity
        self.customView.countLabel.text = movieDetails.count
        self.customView.titleLabel.text = movieDetails.title
        self.customView.genresLabel.text = movieDetails.genres
        self.customView.languagesLabel.text = movieDetails.spokenLanguages
        self.customView.companiesLabel.text = movieDetails.productionCompanies
        self.customView.countriesLabel.text = movieDetails.productionCountries
        self.customView.releaseDateLabel.text = movieDetails.releaseDate
        self.customView.runtimeLabel.text = movieDetails.runTimeMins
    }
}
