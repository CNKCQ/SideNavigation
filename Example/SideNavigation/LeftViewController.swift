
//
//  LeftViewController.swift
//  Slide
//
//  Created by Steve on 2017/8/1.
//  Copyright © 2017年 Jack. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    var tableView: UITableView!
    var items = ["1", "2", "3"]
    var didselected: ((IndexPath) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 180)))
        headerView.backgroundColor = .blue
        tableView.tableHeaderView = headerView
    }

    func startdismiss()  {
        self.dismiss(animated: false, completion: nil)
    }
}

extension LeftViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didselected?(indexPath)
        self.dismiss(animated: true, completion: nil)
    }
}


