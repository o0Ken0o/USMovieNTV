//
//  SearchResultHeaderView.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 26/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class SearchResultHeaderView: UICollectionReusableView {
    static let identifier: String = "SearchResultHeaderView"
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(textLabel)
    }
    
    private func setupConstraints() {
        textLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
        }
    }
    
    func updateWith(title: String) {
        self.textLabel.text = title
    }
}

extension SearchResultHeaderView {

}
