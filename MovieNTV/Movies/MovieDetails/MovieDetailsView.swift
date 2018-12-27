//
//  MoviesView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol MovieDetailsViewDelegate: class {
    func didTapCloseBtn()
}

class MovieDetailsView: UIView {
    weak var delegate: MovieDetailsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            guard let windowSafeInsets = UIApplication.shared.keyWindow?.safeAreaInsets,
                let safeAreaLayoutFrame = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame else { return scrollView }
            let contentSizeHeight = safeAreaLayoutFrame.size.height - windowSafeInsets.top - windowSafeInsets.bottom
            let size = CGSize(width: safeAreaLayoutFrame.size.width, height: contentSizeHeight)
            scrollView.frame = CGRect(origin: CGPoint(x: 0, y: windowSafeInsets.top), size: size)
        } else {
            scrollView.frame = self.frame
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
        label.numberOfLines = 5
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
        label.numberOfLines = 5
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
        label.numberOfLines = 5
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
        label.numberOfLines = 5
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
    
    private func addViews() {
        self.addSubview(scrollView)
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
                make.right.equalTo(self.safeAreaLayoutGuide).offset(-20)
            } else {
                make.top.equalTo(self.scrollView).offset(20)
                make.right.equalTo(self).offset(-20)
            }
            
            make.width.height.equalTo(20)
        }
    }
    
    private func setupPosterImageViewConstraints() {
        self.posterImageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(self)
            make.height.equalTo(self.posterImageView.snp.width).multipliedBy(3.0/2.0)
        }
    }
    
    private func setupPopularityLabelConstraints() {
        self.popularityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.posterImageView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(20)
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
            make.right.equalTo(self).offset(-20)
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
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
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
            make.top.equalTo(self.genresLabel.snp.bottom).offset(5)
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
            make.top.equalTo(self.languagesLabel.snp.bottom).offset(5)
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
            make.top.equalTo(self.companiesLabel.snp.bottom).offset(5)
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
            make.top.equalTo(self.countriesLabel.snp.bottom).offset(5)
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
            make.top.equalTo(self.releaseDateLabel.snp.bottom).offset(5)
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
        self.delegate?.didTapCloseBtn()
    }
}

extension MovieDetailsView {
    func showPoster(image: UIImage?) {
        self.posterImageView.image = image
    }
    
    func displayWith(movie: Movie) {
        show(popularity: movie.popularity)
        show(count: movie.voteCount)
        show(voteAverage: movie.voteAverage)
        show(title: movie.title)
        show(genres: movie.genres)
        show(spokenLanguages: movie.spokenLanguages)
        show(productionCompanies: movie.productionCompanies)
        show(productionCountries: movie.productionCountries)
        show(releaseDate: movie.releaseDate)
        show(runTimeMins: movie.runTimeMins)
    }
    
    private func show(popularity: Float) {
        let popularity = String(format: "%.1f", popularity)
        popularityLabel.text = "☆ \(popularity)"
    }
    
    private func show(count: Int) {
        countLabel.text = "웃 \(count)"
    }
    
    private func show(voteAverage: Float) {
        let countAverageStr = String(format: "%.1f", voteAverage)
        countAverageLabel.text = "♡ \(countAverageStr)"
    }
    
    private func show(title: String) {
        titleLabel.text = title
    }
    
    private func show(genres: [String]?) {
        if let genres = genres, genres.count > 0 {
            var genresStr = genres.reduce("") { genres, next in "\(genres), \(next)" }
            genresStr = String(genresStr.dropFirst(2))
            self.genresLabel.text = genresStr
        }
    }
    
    private func show(spokenLanguages: [String]?) {
        guard let languages = spokenLanguages, languages.count > 0  else {
            languagesLabel.text = ""
            return
        }
        
        var languagesStr = languages.reduce("") { languages, nextLanguage in "\(languages), \(nextLanguage)" }
        languagesStr = String(languagesStr.dropFirst(2))
        self.languagesLabel.text = languagesStr
    }
    
    private func show(productionCompanies: [String]?) {
        guard let companies = productionCompanies, companies.count > 0 else {
            companiesLabel.text = "--"
            return
        }
        
        var companiesStr = companies.reduce("") { companiesStr, nextCompany in "\(companiesStr), \(nextCompany)" }
        companiesStr = String(companiesStr.dropFirst(2))
        companiesLabel.text = companiesStr
    }
    
    private func show(productionCountries: [String]?) {
        guard let countries = productionCountries, countries.count > 0 else {
            countriesLabel.text = "--"
            return
        }
        
        var countriesStr = countries.reduce("") { countriesStr, nextCountry in "\(countriesStr), \(nextCountry)" }
        countriesStr = String(countriesStr.dropFirst(2))
        countriesLabel.text = countriesStr
    }
    
    private func show(releaseDate: Date?) {
        releaseDateLabel.text = "--"
        guard let releaseDate = releaseDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        releaseDateLabel.text = dateFormatter.string(from: releaseDate)
    }
    
    private func show(runTimeMins: Int?) {
        runtimeLabel.text = "--"
        guard let runtime = runTimeMins else { return }
        runtimeLabel.text = "\(runtime)"
    }
}
