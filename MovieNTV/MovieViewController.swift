//
//  MovieViewController.swift
//  MovieNTV
//
//  Created by Ken Siu on 16/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataServices.shared.getLastest { (success: Bool, movie: Movie?) in
            if success {
                
            } else {
                // error handling
            }
        }
    }
    
}

