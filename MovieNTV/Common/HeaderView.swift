//
//  HeaderView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 23/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let identifier = "ReuseHeaderView"
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel(frame: self.frame)
        self.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
