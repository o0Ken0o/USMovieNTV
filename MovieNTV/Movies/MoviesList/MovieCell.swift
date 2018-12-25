//
//  MovieCell.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 23/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    private var releaseDateLabel: UILabel!
    private var popularityLabel: UILabel!
    private var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cleanUp4Reuse() {
        self.posterImageView.image = UIImage(named: "movieNTV")
        self.releaseDateLabel.text = ""
        self.popularityLabel.text = ""
    }
    
    private func initUI() {
        backgroundColor = .gray
        
        self.releaseDateLabel = UILabel()
        self.releaseDateLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.releaseDateLabel.textColor = .white
        self.releaseDateLabel.text = "Release Date"
        self.releaseDateLabel.textAlignment = .center
        
        self.popularityLabel = UILabel()
        self.popularityLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        self.popularityLabel.textColor = .white
        self.popularityLabel.text = "Popularity"
        self.popularityLabel.textAlignment = .center
        
        self.posterImageView = UIImageView()
        self.posterImageView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(releaseDateLabel)
        self.contentView.addSubview(popularityLabel)
        
        self.releaseDateLabel.snp.makeConstraints { (make) in
            make.trailing.leading.top.equalTo(self.contentView)
        }
        
        self.popularityLabel.snp.makeConstraints { (make) in
            make.trailing.leading.bottom.equalTo(self.contentView)
        }
        
        self.posterImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.contentView)
        }
    }
    
    func setupWith(movie: Movie) {
        let popularity = String(format: "%.1f", movie.popularity)
        self.popularityLabel.text = "☆ \(popularity)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        self.releaseDateLabel.text = dateFormatter.string(from: movie.releaseDate!)
        
        if let posterPath = movie.posterPath {
            DataServices.shared.getImage(posterPath: posterPath) { (success, image) in
                if success {
                    self.posterImageView.image = image
                }
            }
        } else {
            self.posterImageView.image = UIImage(named: "movieNTV")
        }
    }
}

extension MovieCell {
    static let identifier: String = {
        return "MovieCell"
    }()
}
