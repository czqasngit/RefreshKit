//
//  ViewController.swift
//  RefreshKit
//
//  Created by czqasngit on 10/23/2018.
//  Copyright (c) 2018 czqasngit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        let header = UIView(frame: CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: 50))
        header.backgroundColor = UIColor.orange
        tableView.insertSubview(header, at: 0)
        
        self.tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change)
    }
    
}

