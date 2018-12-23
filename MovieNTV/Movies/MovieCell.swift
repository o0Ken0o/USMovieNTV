//
//  MovieCell.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 23/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cleanUp4Reuse() {
        
    }
    
    private func setupUI() {
        backgroundColor = .gray
    }
}

extension MovieCell {
    static let identifier: String = {
        return "MovieCell"
    }()
}
