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
    
    var isMovie = true
    
    var movies = [Movie]()
    var tvs = [TV]()
    var sideMenu: SideMenu!
    
    var selectedMovie: Movie?
    var selectedTV: TV?
    
    var indicator: UIActivityIndicatorView!
    var overlayView: UIView!
    let sideMenuItems = SideMenuItems.menuItems
    let sideMenuHeaders = SideMenuItems.headerItems
    
    let Cell_Identifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.backgroundColor = UIColor.black
        
        sideMenu = SideMenu(menuWidth: UIScreen.main.bounds.width * 0.8, parentVC: self.navigationController!, backgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5), tableData: sideMenuItems, headerData: sideMenuHeaders)
        sideMenu.delegate = self
        
        setupOverlayView()
        
        setupView()
        
        loadNowPlayingMovies()
    }
    
    func setupOverlayView() {
        overlayView = UIView(frame: self.view.bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.center = self.overlayView.center
        indicator.startAnimating()
        overlayView.addSubview(indicator)
    }
    
    func addOverlay() {
        if let navVC = self.navigationController {
            navVC.view.addSubview(overlayView)
        } else {
            self.view.addSubview(overlayView)
        }
    }
    
    func removeOverlay() {
        overlayView.removeFromSuperview()
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
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        
        addOverlay()
        
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
            self.removeOverlay()
        }
    }
    
    func loadPopularMovies() {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        
        addOverlay()
        
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
            self.removeOverlay()
        }
    }
    
    func loadTopRatedMovies() {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        
        addOverlay()
        
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
            self.removeOverlay()
        }
    }
    
    func loadUpcomingMovies() {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        
        addOverlay()
        
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
            self.removeOverlay()
        }
    }
    
    func loadAirPlayingTVShows() {
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        
        addOverlay()
        
        DataServices.shared.getAiringToday { (success, tvs) in
            if success {
                if let tvs = tvs {
                    self.tvs = tvs
                    self.moviesCollectionView.reloadData()
                }
            } else {
                print("error")
            }
            
            self.removeOverlay()
        }
    }
    
    
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isMovie ? movies.count : tvs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: Cell_Identifier, for: indexPath) as! MovieCollectionViewCell
        
        if isMovie {
            let movie = movies[indexPath.row]
            
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
        } else {
            let tv = tvs[indexPath.row]
            
            if let firstAirDate = tv.firstAirDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                cell.releaseDateLabel.text = dateFormatter.string(from: firstAirDate)
                cell.releaseDateLabel.isHidden = false
            } else {
                cell.releaseDateLabel.isHidden = true
            }
            
            if let popularity = tv.popularity {
                let popularityStr = String(format: "%.1f", popularity)
                cell.popularityLabel.text = "☆ \(popularityStr)"
                cell.popularityLabel.isHidden = false
            } else {
                cell.popularityLabel.isHidden = true
            }
            
            cell.posterImageView.image = UIImage(named: "movieNTV")
            cell.posterImageView.backgroundColor = UIColor.darkGray
            
            if let posterPath = tv.posterPath {
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
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isMovie {
            selectedMovie = movies[indexPath.row]
            performSegue(withIdentifier: "MovieDetailsViewController", sender: nil)
        } else {
            selectedTV = tvs[indexPath.row]
            performSegue(withIdentifier: "TVShowDetailsViewController", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailsViewController" {
            let movieDetailsVC = segue.destination as! MovieDetailsViewController
            movieDetailsVC.movie = selectedMovie!
        } else if segue.identifier == "TVShowDetailsViewController" {
            let tvDetailsVC = segue.destination as! TVShowDetailsViewController
            tvDetailsVC.tv = selectedTV
        }
    }
    
    // MARK: SideMenuDelegate
    func didSelectAnItem(view: SideMenu, item: String, section:Int, row: Int) {
        self.title = sideMenuItems[section][row]
        if section == 0 {
            isMovie = true
            switch row {
            case 0:
                loadNowPlayingMovies()
            case 1:
                loadPopularMovies()
            case 2:
                loadTopRatedMovies()
            case 3:
                loadUpcomingMovies()
            default:
                loadNowPlayingMovies()
            }
        } else {
            isMovie = false
            switch row {
            case 0:
                loadAirPlayingTVShows()
            default:
                loadAirPlayingTVShows()
            }
        }
        
        sideMenu.toggleMenu(open: false)
    }
}
