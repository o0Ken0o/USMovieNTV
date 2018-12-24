//
//  MovieDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    var dataServices: DataServices!
    var movieId: Int!
    
    private lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            guard let windowSafeInsets = UIApplication.shared.keyWindow?.safeAreaInsets else { return scrollView }
            let safeAreaLayoutFrameSize = self.view.safeAreaLayoutGuide.layoutFrame.size
            let contentSizeHeight = safeAreaLayoutFrameSize.height - windowSafeInsets.top - windowSafeInsets.bottom
            let size = CGSize(width: safeAreaLayoutFrameSize.width, height: contentSizeHeight)
            scrollView.frame = CGRect(origin: CGPoint(x: 0, y: windowSafeInsets.top), size: size)
        } else {
            scrollView.frame = self.view.frame
        }
        return scrollView
    }()

    private lazy var closeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "close_icon"), for: .normal)
        btn.addTarget(self, action: #selector(didTapCloseBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private var posterImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        imgV.backgroundColor = .orange
        return imgV
    }()
    
    private var popularityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "☆ --"
        return label
    }()
    
    private var countAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "♡ --"
        return label
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "웃 --"
        return label
    }()
    
    private var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Title:"
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var genresTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Genres:"
        return label
    }()
    
    private var genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var languagesTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Languages:"
        return label
    }()
    
    private var languagesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var companiesTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Companies:"
        return label
    }()
    
    private var companiesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var countriesTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Countries:"
        return label
    }()
    
    private var countriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var releaseDateTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Release Date:"
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var runtimeTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Runtime:"
        return label
    }()
    
    private var runtimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        addViews()
        setupConstraints()
        
        dataServices.getMovieDetails(movieID: movieId) { [unowned self] (success, movie) in
            if success, let movie = movie {
                self.displayWith(movie: movie)
            }
        }
    }
    
    func displayWith(movie: Movie) {
        if let posterPath = movie.posterPath {
            dataServices.getImage(posterPath: posterPath, with: { (success, image) in
                if success {
                    self.posterImageView.image = image
                }
            })
        }
        
        let popularity = String(format: "%.1f", movie.popularity)
        popularityLabel.text = "☆ \(popularity)"
        
        let count = movie.voteCount
        countLabel.text = "웃 \(count)"
        
        let countAverageStr = String(format: "%.1f", movie.voteAverage)
        countAverageLabel.text = "♡ \(countAverageStr)"
        
        titleLabel.text = movie.title
        
        if let genres = movie.genres, genres.count > 0 {
            var text = ""
            for (i, genreStr) in genres.enumerated() {
                if i != genres.count - 1 {
                    text.append("\(genreStr), ")
                } else {
                    text.append(genreStr)
                }
            }
            genresLabel.text = text
        }
        
        if let languages = movie.spokenLanguages, languages.count > 0 {
            var text = ""
            for (i, languageStr) in languages.enumerated() {
                if i != languages.count - 1 {
                    _ = text.append("\(languageStr), ")
                } else {
                    _ = text.append(languageStr)
                }
            }
            languagesLabel.text = text
        } else {
            languagesLabel.text? = "--"
        }
        
        if let companies = movie.productionCompanies, companies.count > 0 {
            var text = ""
            for (i, companyStr) in companies.enumerated() {
                if i != companies.count - 1 {
                    _ = text.append("\(companyStr), ")
                } else {
                    _ = text.append(companyStr)
                }
            }
            companiesLabel.text = text
        } else {
            companiesLabel.text? = "--"
        }
        
        if let countries = movie.productionCountries, countries.count > 0 {
            var text = ""
            for (i, countryStr) in countries.enumerated() {
                if i != countries.count - 1 {
                    _ = text.append("\(countryStr), ")
                } else {
                    _ = text.append(countryStr)
                }
                
            }
            countriesLabel.text = text
        } else {
            countriesLabel.text = "--"
        }
        
        if let releaseDate = movie.releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd"
            releaseDateLabel.text = dateFormatter.string(from: releaseDate)
        } else {
            releaseDateLabel.text = "--"
        }
        
        if let runtime = movie.runTimeMins {
            runtimeLabel.text = "\(runtime)"
        } else {
            runtimeLabel.text = "--"
        }
    }
    
    private func addViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(posterImageView)
        self.scrollView.addSubview(popularityLabel)
        self.scrollView.addSubview(countAverageLabel)
        self.scrollView.addSubview(countLabel)
        self.scrollView.addSubview(titleTextLabel)
        self.scrollView.addSubview(titleLabel)
        self.scrollView.addSubview(genresTextLabel)
        self.scrollView.addSubview(genresLabel)
        self.scrollView.addSubview(languagesTextLabel)
        self.scrollView.addSubview(languagesLabel)
        self.scrollView.addSubview(companiesTextLabel)
        self.scrollView.addSubview(companiesLabel)
        self.scrollView.addSubview(countriesTextLabel)
        self.scrollView.addSubview(countriesLabel)
        self.scrollView.addSubview(releaseDateTextLabel)
        self.scrollView.addSubview(releaseDateLabel)
        self.scrollView.addSubview(runtimeTextLabel)
        self.scrollView.addSubview(runtimeLabel)
        self.scrollView.addSubview(closeBtn)
    }
    
    private func setupConstraints() {
        setupCloseBtnConstraints()
        setupPosterImageViewConstraints()
        setupPopularityLabelConstraints()
        setupCountAverageLabelConstraints()
        setupCountLabelConstraints()
        setupTitleLabelConstraints()
        setupGenresLabelConstraints()
        setupLanguagesLabelConstraints()
        setupCompaniesLabelConstraints()
        setupCountriesLabelConstraints()
        setupReleaseDateLabelConstraints()
        setupRunTimeLabelConstraints()
    }
    
    private func setupCloseBtnConstraints() {
        self.closeBtn.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(self.scrollView).offset(20)
                make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            } else {
                make.top.equalTo(self.scrollView).offset(20)
                make.right.equalTo(self.view).offset(-20)
            }
            
            make.width.height.equalTo(20)
        }
    }
    
    private func setupPosterImageViewConstraints() {
        self.posterImageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.posterImageView.snp.width).multipliedBy(3.0/2.0)
        }
    }
    
    private func setupPopularityLabelConstraints() {
        self.popularityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(10)
            make.left.equalTo(self.view).offset(20)
            make.height.equalTo(20)
        }
    }
    
    private func setupCountAverageLabelConstraints() {
        self.countAverageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularityLabel)
            make.left.equalTo(self.popularityLabel.snp.right)
            make.height.width.equalTo(self.popularityLabel)
        }
    }
    
    private func setupCountLabelConstraints() {
        self.countLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularityLabel)
            make.right.equalTo(self.view).offset(-20)
            make.left.equalTo(self.countAverageLabel.snp.right)
            make.height.width.equalTo(self.popularityLabel)
        }
    }
    
    private func setupTitleLabelConstraints() {
        self.titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.popularityLabel.snp.bottom).offset(49.5)
            make.left.equalTo(self.popularityLabel)
            make.width.equalTo(95)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleTextLabel)
            make.left.equalTo(self.titleTextLabel.snp.right).offset(10)
            make.right.equalTo(self.countLabel)
        }
    }
    
    private func setupGenresLabelConstraints() {
        self.genresTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.genresLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.genresTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupLanguagesLabelConstraints() {
        self.languagesTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.genresTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.languagesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.languagesTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupCompaniesLabelConstraints() {
        self.companiesTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.languagesTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.companiesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.companiesTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupCountriesLabelConstraints() {
        self.countriesTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.companiesTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.countriesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.countriesTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupReleaseDateLabelConstraints() {
        self.releaseDateTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.countriesTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.releaseDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.releaseDateTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupRunTimeLabelConstraints() {
        self.runtimeTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.releaseDateTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.runtimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.runtimeTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
            make.bottom.equalTo(self.scrollView.snp.bottom)
        }
    }
    
    @objc private func didTapCloseBtn(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
