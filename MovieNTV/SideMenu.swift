//
//  SideMenu.swift
//  MovieNTV
//
//  Created by Ken Siu on 18/12/2016.
//  Copyright © 2016 Ken Siu. All rights reserved.

import UIKit

protocol SideMenuDelegate {
    func didSelectAnItem(view: SideMenu, item: String, section:Int, row: Int)
}

class SideMenu: UIView, UITableViewDataSource, UITableViewDelegate {
    var backgroundView: UIView!
    var animator: UIDynamicAnimator!
    var menuWidth: CGFloat!
    var bgColor: UIColor!
    
    var tableView: UITableView!
    var tableData = [[String]]()
    var headerData = [String]()
    
    var delegate: SideMenuDelegate?
    
    var parentViewController: UIViewController!
    
    convenience init(menuWidth: CGFloat, parentVC: UIViewController) {
        self.init(menuWidth: menuWidth, parentVC: parentVC, backgroundColor: UIColor.orange, tableData: [[]], headerData: [])
    }
    
    init(menuWidth: CGFloat, parentVC: UIViewController, backgroundColor: UIColor, tableData: [[String]], headerData: [String]) {
        super.init(frame: CGRect(x: -menuWidth - 20, y: 0, width: menuWidth, height: parentVC.view.bounds.height))
        
        self.menuWidth = menuWidth
        self.parentViewController = parentVC
        
        self.bgColor = backgroundColor
        self.backgroundColor = backgroundColor
        parentVC.view.addSubview(self)
        
        animator = UIDynamicAnimator(referenceView: parentVC.view)
        
        self.tableData = tableData
        self.headerData = headerData
        
        setupView(parentVC: parentVC)
        
        let swipeOpenGest = UISwipeGestureRecognizer(target: self, action: #selector(SideMenu.handleGestures(recognizer:)))
        swipeOpenGest.direction = .right
        if let navVC = parentVC as? UINavigationController {
            navVC.viewControllers.first?.view.addGestureRecognizer(swipeOpenGest)
        } else {
            parentVC.view.addGestureRecognizer(swipeOpenGest)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func handleGestures(recognizer: UIGestureRecognizer) {
        if let swipe = recognizer as? UISwipeGestureRecognizer {
            if swipe.direction == .right {
                toggleMenu(open: true)
            } else {
                toggleMenu(open: false)
            }
        }
        
        if let _ = recognizer as? UITapGestureRecognizer {
            toggleMenu(open: false)
        }
    }
    
    func toggleMenu(open: Bool) {
        let gravityDirectionX: CGFloat = open ? 10 : -10
        let boundaryX: CGFloat = open ? menuWidth : (-menuWidth - 20)
        
        let gravityBeha = UIGravityBehavior(items: [self])
        gravityBeha.gravityDirection = CGVector(dx: gravityDirectionX, dy: 0)
        animator.addBehavior(gravityBeha)
        
        let collisionBeha = UICollisionBehavior(items: [self])
        collisionBeha.addBoundary(withIdentifier: 1 as NSCopying, from: CGPoint(x: boundaryX, y: 0), to: CGPoint(x: boundaryX, y: parentViewController.view.bounds.height))
        animator.addBehavior(collisionBeha)
        
        if open {
            parentViewController.view.insertSubview(backgroundView, belowSubview: self)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.alpha = open ? 0.8 : 0
        }) { (finished: Bool) in
            if !open {
                self.backgroundView.removeFromSuperview()
            }
        }
    }
    
    func setupView(parentVC: UIViewController) {
        backgroundView = UIView(frame: parentVC.view.frame)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SideMenu.handleGestures(recognizer:)))
        backgroundView.addGestureRecognizer(tap)
        
        let swipeCloseGest = UISwipeGestureRecognizer(target: self, action: #selector(SideMenu.handleGestures(recognizer:)))
        swipeCloseGest.direction = .left
        backgroundView.addGestureRecognizer(swipeCloseGest)
        
        parentVC.view.insertSubview(backgroundView, belowSubview: self)
        
        var tableViewBounds = self.bounds
        tableViewBounds.origin.y += 100
        tableViewBounds.size.height -= 100
        tableView = UITableView(frame: tableViewBounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = bgColor
        tableView.isScrollEnabled = false
        self.addSubview(tableView)
        
        let imageView = UIImageView(image: UIImage(named: "movieNTV"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center.x = self.bounds.width / 2.0
        imageView.alpha = 0.8
        imageView.backgroundColor = bgColor
        self.addSubview(imageView)
        
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = bgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerData[section]
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectAnItem(view: self, item: tableData[indexPath.section][indexPath.row], section: indexPath.section, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        headerView.backgroundColor = bgColor
        
        let headerText = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.bounds.width, height: 30))
        headerText.text = headerData[section]
        headerText.textColor = UIColor.white
        headerText.font = UIFont(name: "Helvetica-Bold", size: 20)
        headerView.addSubview(headerText)
        
        return headerView
    }
    
}

