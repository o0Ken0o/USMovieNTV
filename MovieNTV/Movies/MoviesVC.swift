//
//  MoviesVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 22/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit
import SnapKit

class MoviesVC: UIViewController {
    lazy var collectionView: UICollectionView = { [unowned self, viewFrame = self.view.frame] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.headerReferenceSize = CGSize(width: viewFrame.size.width, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "MyCell")
        collectionView.contentSize = CGSize(width: 1000, height: 300)

        collectionView.register(HeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        
        if #available(iOS 11, *) {
            self.collectionView.snp.makeConstraints { (make) in
                make.top.left.right.equalTo(self.view)
                make.height.equalTo(300)
            }
        }
    }
}

extension MoviesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else { return HeaderView() }
        view.textLabel.text = "\(indexPath.section) \(indexPath.row)"
        return view
    }
}

extension MoviesVC: UICollectionViewDelegate {
    
}
