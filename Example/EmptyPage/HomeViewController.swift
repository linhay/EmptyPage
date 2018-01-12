//
//  HomeViewController.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

class HomeViewController: UITableViewController {

  struct Section {
    let title: String
    let items: [CellItem]
  }

  struct CellItem {
    let title: String
    let subTitle: String
    let emptyView: EmptyPageView
  }


  var sections = [Section]()


  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 50
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.sectionHeaderHeight = 40
    buildSectionForDefault()
    buildSectionForCustom()
  }


  func buildSectionForCustom() {
    var items = [CellItem]()
    do{
      let view = EmptyPageForCustom.initFromNib
      view.imageView.image = UIImage(named: "empty")
      view.label.text = "描述文本"
      let item = CellItem(title: "自定义样式",
                          subTitle: "一",
                          emptyView: .mix(view: view))
      items.append(item)
    }
    sections.append(Section(title: "自定义样式",items: items))
  }

  func buildSectionForDefault() {
    var items = [CellItem]()
    let images = (0...3).map { (item) -> UIImage in
      return UIImage(named: "load-\(item)")!
    }

    let attributed = NSMutableAttributedString(string: "富文本-",
                                               attributes: [.font : UIFont.boldSystemFont(ofSize: 30),
                                                            .foregroundColor: UIColor.red])
    let attributed2 = NSAttributedString(string: "样式",
                                         attributes: [.font : UIFont.systemFont(ofSize: 20),
                                                      .foregroundColor: UIColor.black])
    attributed.append(attributed2)

    do {
      let item = CellItem(title: "纯文字",
                          subTitle: "默认样式",
                          emptyView: .onlyText(text: "纯文字-默认样式"))
      items.append(item)
    }

    do {
      let item = CellItem(title: "纯文字",
                          subTitle: "富文本样式",
                          emptyView: .onlyText(attributed: attributed))
      items.append(item)
    }

    do{
      let item = CellItem(title: "纯图片",
                          subTitle: "默认样式",
                          emptyView: .onlyImage(image: UIImage(named: "empty")!))
      items.append(item)
    }

    do{
      let item = CellItem(title: "纯图片",
                          subTitle: "图片组样式",
                          emptyView: .onlyImages(images: images,
                                                 duration: 1.5,
                                                 repeatCount: 0))
      items.append(item)
    }


    do{
      let item = CellItem(title: "标准",
                          subTitle: "默认样式",
                          emptyView: .standard(images: [UIImage(named: "empty")!],
                                               title: "标题",
                                               text: "详情文本",
                                               btnTitle: "按钮文本",
                                               event: {
                                                self.alertEvent()
                          }))
      items.append(item)
    }

    do{
      let item = CellItem(title: "标准",
                          subTitle: "富文本样式",
                          emptyView: .standard(images: images,
                                               duration: 1.5,
                                               repeatCount: 0,
                                               title: attributed,
                                               text: attributed,
                                               btnTitle: "按钮文本",
                                               btnTitleColor: .white,
                                               btnTitleFont: .boldSystemFont(ofSize: 18),
                                               btnBackColor: .darkGray,
                                               event: {
                                                self.alertEvent()
                          }))
      items.append(item)
    }
    sections.append(Section(title: "标准样式",items: items))
  }

  func alertEvent() {
    let alert = UIAlertController(title: "点击事件",message: nil,preferredStyle: .alert)
    let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
    alert.addAction(action)
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
  }


  override func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].items.count
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UITableViewHeaderFooterView(reuseIdentifier: "header")
    view.textLabel?.text = sections[section].title
    return view
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    cell.textLabel?.text = sections[indexPath.section].items[indexPath.item].title
    cell.detailTextLabel?.text = sections[indexPath.section].items[indexPath.item].subTitle
    return cell
  }



  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = UITableViewController(style: .plain)
    vc.tableView.separatorStyle = .none
    vc.tableView.setEmpty(view: sections[indexPath.section].items[indexPath.item].emptyView)
    navigationController?.pushViewController(vc, animated: true)
  }


}
