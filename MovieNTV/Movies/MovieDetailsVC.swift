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
    
    private lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        if #available(iOS 11, *) {
            scrollView.contentSize = self.view.safeAreaLayoutGuide.layoutFrame.size
        } else {
            scrollView.contentSize = self.view.frame.size
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
        label.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "☆ --"
        return label
    }()
    
    private var countAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "♡ --"
        return label
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "웃 --"
        return label
    }()
    
    private var titleTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Title:"
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 15.0)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        addViews()
        setupConstraints()
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
    }
    
    private func addViews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(posterImageView)
        self.scrollView.addSubview(popularityLabel)
        self.scrollView.addSubview(countAverageLabel)
        self.scrollView.addSubview(countLabel)
        self.scrollView.addSubview(titleTextLabel)
        self.scrollView.addSubview(titleLabel)
        self.scrollView.addSubview(closeBtn)
    }
    
    private func setupConstraints() {
        setupCloseBtnConstraints()
        setupScrollViewConstraints()
        setupPosterImageViewConstraints()
        setupPopularityLabelConstraints()
        setupCountAverageLabelConstraints()
        setupCountLabelConstraints()
        setupTitleLabelConstraints()
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
    
    private func setupScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.top.bottom.left.right.equalTo(self.view)
            }
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
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleTextLabel)
            make.left.equalTo(self.titleTextLabel.snp.right)
            make.right.equalTo(self.countLabel)
        }
    }
    
    @objc private func didTapCloseBtn(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
