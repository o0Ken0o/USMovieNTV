//
//  UIViewController.swift
//  MovieNTV
//
//  Created by Kam Hei Siu on 24/12/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol HasCustomView {
    associatedtype CustomView: UIView
}

extension HasCustomView where Self: UIViewController {
    internal var customView: CustomView {
        guard let customView = view as? CustomView else { fatalError("no custom view available") }
        return customView
    }
}
