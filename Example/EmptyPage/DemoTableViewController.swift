//
//  DemoTableViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {

  var items = [String]()
  var sections = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
    tableView.setEmpty(view: EmptyStates.loading)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    getData()
  }
  
  
  func getData() {
    tableView.setEmpty(view: EmptyStates.loading)
    tableView.reloadData()
    sleep(3) {[weak self] in
      guard let base = self else { return }
      base.tableView.emptyView = EmptyStates.custom(block1: {[weak self] in
        guard let base = self else { return }
        base.getData()
      }) {[weak self] in
        guard let base = self else { return }
        base.items = ["点击重新加载","点击添加行","点击删除行"]
        base.tableView.reloadData()
      }
      base.tableView.reloadData()
    }
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sections
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      items.removeLast()
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    cell.textLabel?.text = items[indexPath.item]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.item]
    switch item {
    case "点击重新加载":
      items.removeAll()
      tableView.reloadData()
      getData()
    case "点击添加行":
      tableView.beginUpdates()
      items.append("new row")
      tableView.insertRows(at: [IndexPath(row: tableView.numberOfRows(inSection: indexPath.section), section: indexPath.section)], with: .automatic)
      tableView.endUpdates()
    case "点击删除行":
      tableView.beginUpdates()
      items.removeLast()
      let index = IndexPath(row: tableView.numberOfRows(inSection: indexPath.section) - 1, section: indexPath.section)
      tableView.deleteRows(at: [index], with: .automatic)
      tableView.endUpdates()
    default: break
    }
  }
  
}
