//
//  TableViewController.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

class TableViewController: UITableViewController {

  var count = 0 {
    didSet{
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
    getData()
  }


  func getData() {
    tableView?.emptyView = EmptyView.loading()
    tableView?.reloadData()
    /// 延时5s模拟网络请求
    let time = DispatchTime.now() + .milliseconds(Int(5 * 1000))
    DispatchQueue.global().asyncAfter(deadline: time) {
      DispatchQueue.main.async { [weak self] in
        guard let base = self else { return }
        base.tableView?.emptyView = EmptyView.noData(block1: {
          base.count = 50
        }){
          base.getData()
        }
        base.tableView?.reloadData()
      }
    }
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = "点击清空"
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    count = 0
  }

}

