//
//  MoviesViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 18/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SideMenuDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionOrTableBarButton: UIBarButtonItem!
    
    
    var isMovie = true
    var isCollectionView = true
    
    var movies = [Movie]()
    var tvs = [TV]()
    var sideMenu: SideMenu!
    
    var selectedMovie: Movie?
    var selectedTV: TV?
    
    var indicator: UIActivityIndicatorView!
    var overlayView: UIView!
    let sideMenuItems = SideMenuItems.menuItems
    let sideMenuHeaders = SideMenuItems.headerItems
    
    var moviesTableView: UITableView!
    
    let Cell_Identifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
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
        
        var frame = self.view.frame
        frame.origin = self.moviesCollectionView.frame.origin
        frame.size.height -= (self.navigationController?.navigationBar.bounds.height)!
        moviesTableView = UITableView(frame: frame)
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.backgroundColor = UIColor.black
        moviesTableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    @IBAction func tableOrCollectionView(_ sender: Any) {
        
        if isCollectionView {
            isCollectionView = false
            self.moviesCollectionView.isHidden = true
            self.view.addSubview(moviesTableView)
            collectionOrTableBarButton.image = UIImage(named: "collectionView")
        } else {
            isCollectionView = true
            self.moviesCollectionView.isHidden = false
            self.moviesTableView.removeFromSuperview()
            collectionOrTableBarButton.image = UIImage(named: "tableView")
        }
    }
    
    func loadNowPlayingMovies() {
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
    
    func loadTVOnTheAir() {
        addOverlay()
        
        DataServices.shared.getTVOnTheAir { (success, tvs) in
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
    
    func loadTVPopular() {
        addOverlay()
        
        DataServices.shared.getTVPopular { (success, tvs) in
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
    
    func loadTVTopRated() {
        addOverlay()
        
        DataServices.shared.getTVTopRated { (success, tvs) in
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
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isMovie ? movies.count : tvs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.posterImageView.image = UIImage(named: "movieNTV")
        cell.firstAirDateLabel.text = "--"
        cell.popularityLabel.text = "☆ --"
        cell.titleLabel.text = "title: --"
        
        if isMovie {
            let movie = movies[indexPath.row]
            if let posterImagePath = movie.posterPath {
                DataServices.shared.getImage(posterPath: posterImagePath, with: { (success, image) in
                    if success, let image = image {
                        cell.posterImageView.image = image
                    }
                })
            }
            
            if let releaseDate = movie.releaseDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                cell.firstAirDateLabel.text = dateFormatter.string(from: releaseDate)
            }
            
            
            let popularityStr = String(format: "%.1f", movie.popularity)
            cell.popularityLabel.text = "☆ \(popularityStr)"
            
            cell.titleLabel.text = movie.originalTitle
            
        } else {
            let tv = tvs[indexPath.row]
            if let posterImagePath = tv.posterPath {
                DataServices.shared.getImage(posterPath: posterImagePath, with: { (success, image) in
                    if success, let image = image {
                        cell.posterImageView.image = image
                    }
                })
            }
            
            if let firstAirDate = tv.firstAirDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd"
                cell.firstAirDateLabel.text = dateFormatter.string(from: firstAirDate)
            }
            
            if let popularity = tv.popularity {
                let popularityStr = String(format: "%.1f", popularity)
                cell.popularityLabel.text = "☆ \(popularityStr)"
            }
            
            if let titleStr = tv.originalName {
                cell.titleLabel.text = titleStr
            }
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isMovie {
            selectedMovie = movies[indexPath.row]
            performSegue(withIdentifier: "MovieDetailsViewController", sender: nil)
        } else {
            selectedTV = tvs[indexPath.row]
            performSegue(withIdentifier: "TVShowDetailsViewController", sender: nil)
        }
        
    }
    
    // MARK: SideMenuDelegate
    func didSelectAnItem(view: SideMenu, item: String, section:Int, row: Int) {
        
        self.title = sideMenuItems[section][row]
        moviesCollectionView.setContentOffset(CGPoint.zero, animated: true)
        moviesTableView.setContentOffset(CGPoint.zero, animated: true)
        
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
            case 1:
                loadTVOnTheAir()
            case 2:
                loadTVPopular()
            case 3:
                loadTVTopRated()
            default:
                loadAirPlayingTVShows()
            }
        }
        
        sideMenu.toggleMenu(open: false)
    }
}
