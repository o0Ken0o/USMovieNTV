//
//  UIFont.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

extension UIFont {
    enum FontWeight {
        case light, normal
    }
    
    static func helveticaNeue(weight: FontWeight, size: CGFloat) -> UIFont? {
        switch weight {
        case .light:
            return UIFont(name: "HelveticaNeue-Light", size: size)
        case .normal:
            return UIFont(name: "HelveticaNeue", size: size)
        }
    }
}
