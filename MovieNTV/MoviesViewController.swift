//
//  MoviesViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 18/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SideMenuDelegate {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var movies = [Movie]()
    var sideMenu: SideMenu!
    
    let Cell_Identifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.backgroundColor = UIColor.black
        
        sideMenu = SideMenu(menuWidth: UIScreen.main.bounds.width / 2.5, parentVC: self.navigationController!, backgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5), tableData: ["Now Playing", "Popular"])
        sideMenu.delegate = self
        
        setupView()
        
        loadNowPlayingMovies()
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        sideMenu.toggleMenu(open: true)
    }
    
    func setupView() {
        let screenWidth = UIScreen.main.bounds.width
        let cellSpace: CGFloat = 1.0
        let cellWidth = screenWidth / 3.0 - 2 * cellSpace
        let cellHeight = cellWidth * 16 / 10
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewFlowLayout.minimumLineSpacing = cellSpace * 3
        collectionViewFlowLayout.minimumInteritemSpacing = cellSpace
        moviesCollectionView.collectionViewLayout = collectionViewFlowLayout
    }
    
    func loadNowPlayingMovies() {
        DataServices.shared.getNowPlaying { (success, movies) in
            if success {
                if let movies = movies {
                    self.movies = movies
                    self.moviesCollectionView.reloadData()
                }
            } else {
                // error handling
                print("error")
            }
        }
    }
    
    func loadPopularMovies() {
        DataServices.shared.getPopular { (success, movies) in
            if success {
                if let movies = movies {
                    self.movies = movies
                    self.moviesCollectionView.reloadData()
                }
            } else {
                // error handling
                print("error")
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: Cell_Identifier, for: indexPath) as! MovieCollectionViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        cell.releaseDateLabel.text = dateFormatter.string(from: movie.releaseDate!)
        
        let popularity = String(format: "%.1f", movie.popularity)
        cell.popularityLabel.text = "☆ \(popularity)"
        
        DataServices.shared.getImage(posterPath: movie.posterPath!) { (success, image) in
            if success {
                cell.posterImageView.image = image
            }
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    // MARK: SideMenuDelegate
    func didSelectAnItem(view: SideMenu, item: String, index: Int) {
        switch index {
        case 0:
            loadNowPlayingMovies()
        case 1:
            loadPopularMovies()
        default:
            loadNowPlayingMovies()
        }
        sideMenu.toggleMenu(open: false)
    }
}
