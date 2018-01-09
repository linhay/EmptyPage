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

  let emptyView = EmptyView.initFromNib

  var count = 0 {
    didSet{
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.emptyView = emptyView
    emptyView.delegate = self
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

extension TableViewController: EmptyViewDelegate {
  func emptyView(view: EmptyView, tapEvent: UIButton) {
    count = 10
  }
}


