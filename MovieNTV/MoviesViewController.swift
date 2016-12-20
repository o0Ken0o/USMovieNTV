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
    
    var selectedMovie: Movie?
    
    var indicator: UIActivityIndicatorView!
    var overlayView: UIView!
    var sideMenuItems = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    
    let Cell_Identifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.backgroundColor = UIColor.black
        
        sideMenu = SideMenu(menuWidth: UIScreen.main.bounds.width * 0.8, parentVC: self.navigationController!, backgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5), tableData: sideMenuItems)
        sideMenu.delegate = self
        
        overlayView = UIView(frame: self.view.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.center = self.overlayView.center
        indicator.startAnimating()
        overlayView.addSubview(indicator)
        
        
        setupView()
        
        loadNowPlayingMovies(menuIndex: 0)
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
    
    func loadNowPlayingMovies(menuIndex: Int) {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        self.navigationController?.view.addSubview(overlayView)
        self.title = sideMenuItems[menuIndex]
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
            self.overlayView.removeFromSuperview()
        }
    }
    
    func loadPopularMovies(menuIndex: Int) {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        self.navigationController?.view.addSubview(overlayView)
        self.title = sideMenuItems[menuIndex]
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
            self.overlayView.removeFromSuperview()
        }
    }
    
    func loadTopRatedMovies(menuIndex: Int) {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        self.navigationController?.view.addSubview(overlayView)
        self.title = sideMenuItems[menuIndex]
        DataServices.shared.getTopRated { (success, movies) in
            if success {
                if let movies = movies {
                    self.movies = movies
                    self.moviesCollectionView.reloadData()
                }
            } else {
                // error handling
                print("error")
            }
            self.overlayView.removeFromSuperview()
        }
    }
    
    func loadUpcomingMovies(menuIndex: Int) {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        self.navigationController?.view.addSubview(overlayView)
        self.title = sideMenuItems[menuIndex]
        DataServices.shared.getUpcoming { (success, movies) in
            if success {
                if let movies = movies {
                    self.movies = movies
                    self.moviesCollectionView.reloadData()
                }
            } else {
                // error handling
                print("error")
            }
            self.overlayView.removeFromSuperview()
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
        
        cell.posterImageView.image = UIImage(named: "movieNTV")
        cell.posterImageView.backgroundColor = UIColor.darkGray
        
        if let posterPath = movie.posterPath {
            DataServices.shared.getImage(posterPath: posterPath) { (success, image) in
                if success {
                    cell.posterImageView.image = image
                }
            }
        } else {
            cell.posterImageView.image = UIImage(named: "movieNTV")
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: "MovieDetailsViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailsViewController" {
            let movieDetailsVC = segue.destination as! MovieDetailsViewController
            movieDetailsVC.movie = selectedMovie!
        }
    }
    
    // MARK: SideMenuDelegate
    func didSelectAnItem(view: SideMenu, item: String, index: Int) {
        switch index {
        case 0:
            loadNowPlayingMovies(menuIndex: 0)
        case 1:
            loadPopularMovies(menuIndex: 1)
        case 2:
            loadTopRatedMovies(menuIndex: 2)
        case 3:
            loadUpcomingMovies(menuIndex: 3)
        default:
            loadNowPlayingMovies(menuIndex: 0)
        }
        sideMenu.toggleMenu(open: false)
    }
}
