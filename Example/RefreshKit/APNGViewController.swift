//
//  ViewController.swift
//  RefreshKit
//
//  Created by czqasngit on 10/23/2018.
//  Copyright (c) 2018 czqasngit. All rights reserved.
//

import UIKit
import SwiftRefreshKit


class APNGViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var count: Int = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "APNG Animate Test"
        self.view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = true
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        self.extendedLayoutIncludesOpaqueBars = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        let path = Bundle.main.path(forResource: "loading2", ofType: "png")!
        let frames = (1...45).map {
            return String.init(format: "refresh_%d", $0)
        }
        
        self.tableView.refresh.header = RefreshCustomFramesHeader.makeCustom(frames.map { UIImage(named: $0)! }, 0) {
            [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
                self.count = 10
                self.tableView.reloadData()
                self.tableView.refresh.header?.stopRefresh()
                self.tableView.refresh.footer?.resetNoMoreData()
            })
        }
        self.tableView.refresh.footer = RefreshDefaultFooter.make {[weak self] in
            guard let self = self else { return }
            if self.count >= 20 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
                    self.tableView.reloadData()
                    self.tableView.refresh.footer?.noMoreData()
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.count += 10
                    self.tableView.reloadData()
                    self.tableView.refresh.footer?.stopRefresh()
                })
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "第 \(indexPath.row) 行"
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

