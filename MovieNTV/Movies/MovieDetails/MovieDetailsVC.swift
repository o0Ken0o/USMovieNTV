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
            self.customView.displayWith(vm: self.movieDetailsVM)
        }
        
        movieDetailsVM.fetchMovieDetails()
    }
}

extension MovieDetailsVC: MovieDetailsViewDelegate {
    func didTapCloseBtn() {
        self.dismiss(animated: true)
    }
}
