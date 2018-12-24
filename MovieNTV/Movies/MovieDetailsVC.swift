//
//  MovieDetailsVC.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {
    private lazy var closeBtn: UIButton = { [unowned self] in
        let btn = UIButton()
        btn.setImage(UIImage(named: "close_icon"), for: .normal)
        btn.addTarget(self, action: #selector(didTapCloseBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        self.view.addSubview(closeBtn)
    }
    
    private func setupConstraints() {
        setupCloseBtnConstraints()
    }
    
    private func setupCloseBtnConstraints() {
        self.closeBtn.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
                make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            } else {
                make.top.equalTo(self.view).offset(20)
                make.right.equalTo(self.view).offset(-20)
            }
            
            make.width.height.equalTo(20)
        }
    }
    
    @objc private func didTapCloseBtn(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
