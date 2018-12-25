//
//  TVDetailsView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 25/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol TVDetailsViewDelegate: class {
    func didTapCloseBtn()
}

class TVDetailsView: UIView {
    weak var delegate: TVDetailsViewDelegate?
    
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
    
    private var createdByTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Created By:"
        return label
    }()
    
    private var createdByLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var noOfSeasonTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "No Of Seasons:"
        return label
    }()
    
    private var noOfSeasonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .light, size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var noOfEpisodesTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "No of Episodes:"
        return label
    }()
    
    private var noOfEpisodesLabel: UILabel = {
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
    
    private var overviewTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.helveticaNeue(weight: .normal, size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Overview:"
        return label
    }()
    
    private var overviewLabel: UILabel = {
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
        self.scrollView.addSubview(createdByTextLabel)
        self.scrollView.addSubview(createdByLabel)
        self.scrollView.addSubview(noOfSeasonTextLabel)
        self.scrollView.addSubview(noOfSeasonLabel)
        self.scrollView.addSubview(noOfEpisodesTextLabel)
        self.scrollView.addSubview(noOfEpisodesLabel)
        self.scrollView.addSubview(runtimeTextLabel)
        self.scrollView.addSubview(runtimeLabel)
        self.scrollView.addSubview(overviewTextLabel)
        self.scrollView.addSubview(overviewLabel)
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
        setupnoOfSeasonLabelConstraints()
        setupnoOfEpisodesLabelConstraints()
        setupRunTimeLabelConstraints()
        setupOverviewLabelConstraints()
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
        self.createdByTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.languagesTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.createdByLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.createdByTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupnoOfSeasonLabelConstraints() {
        self.noOfSeasonTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.createdByTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.noOfSeasonLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.noOfSeasonTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupnoOfEpisodesLabelConstraints() {
        self.noOfEpisodesTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.noOfSeasonTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.noOfEpisodesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.noOfEpisodesTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupRunTimeLabelConstraints() {
        self.runtimeTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.noOfEpisodesTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.runtimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.runtimeTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
        }
    }
    
    private func setupOverviewLabelConstraints() {
        self.overviewTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.runtimeTextLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self.titleTextLabel)
        }
        
        self.overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.overviewTextLabel)
            make.left.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel)
            make.bottom.equalTo(self.scrollView.snp.bottom)
        }
    }
    
    @objc private func didTapCloseBtn(sender: UIButton) {
        self.delegate?.didTapCloseBtn()
    }
}

extension TVDetailsView {
    func showPoster(image: UIImage?) {
        self.posterImageView.image = image
    }
}
