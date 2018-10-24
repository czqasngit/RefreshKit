//
//  ViewController.swift
//  RefreshKit
//
//  Created by czqasngit on 10/23/2018.
//  Copyright (c) 2018 czqasngit. All rights reserved.
//

import UIKit
import RefreshKit

class MyRefreshBasic: RefreshBasic {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel(frame: .init(x: 0, y: 0, width: 100, height: 30))
        label.textColor = UIColor.orange
        label.text = "刷新"
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class MyTableView: UITableView {
    deinit {
        print("MyTableView deinit")
    }
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = MyTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "KVOObject Test"
        self.view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor.yellow
        let refreshBasic = MyRefreshBasic(frame: CGRect.init(x: 0, y: -100, width: self.view.frame.size.width, height: 100))
        refreshBasic.backgroundColor = UIColor.purple
        self.tableView.refresh.header = refreshBasic
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "第 \(indexPath.row) 行"
        return cell
    }
}

