//
//  HomeViewController.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import Hue

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
    title = "EmptyPage"
    tableView.rowHeight = 50
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.sectionHeaderHeight = 40
    buildDemos()
    buildSectionForDefault()
    buildSectionForCustom()
    buildByDribbble()
    buildByEmptystat()
  }
  
  func buildDemos() {
    let table = CellItem(title: "tableView示例", subTitle: "tableView", emptyView: EmptyPageView())
    let collection = CellItem(title: "collectionView示例", subTitle: "collectionView", emptyView: EmptyPageView())
    sections.append(Section(title: "完整示例", items: [table,collection]))
  }
  
  
  func buildByEmptystat() {
    var items = [CellItem]()
    
    if true {
      // http://emptystat.es/image/167120251047
      let emptyView = EmptyPageView.ContentView.standard
        .change(hspace: .button, value: 30)
        .change(vspace: .textWithButton, value: 10)
        .change(vspace: .titleWithText, value: 10)
        .config(button: { (item) in
          item.layer.borderColor = UIColor(hex: "#2ca3fa").cgColor
          item.layer.borderWidth = 1
          item.layer.cornerRadius = 5
          item.titleLabel?.font = UIFont.systemFont(ofSize: 14)
          item.backgroundColor = .white
          item.setTitleColor(UIColor(hex: "#2ca3fa"), for: .normal)
          item.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        })
        .set(image: UIImage(named: "empty-1001")!)
        .set(title: "Nobody is following",
             color: UIColor(hex: "#536571"),
             font: UIFont.boldSystemFont(ofSize: 18))
        .set(text: "Following people helps you keep what they're saying and recommending.",
             color: UIColor(hex: "#c3ccd1"))
        .set(buttonTitle: "Find interesting people to follow >>")
        .set(tap: alertEvent())
        .mix()
        .set(backgroundColor: UIColor.white)
      let item = CellItem(title: "emptystat.es",
                          subTitle: "http://emptystat.es/image/167120251047",
                          emptyView: emptyView)
      items.append(item)
    }
    
    if true {
      // http://emptystat.es/image/162198623343
      let emptyView = EmptyPageView.ContentView.standard
        .change(hspace: .button, value: 80)
        .change(height: .button, value: 60)
        .change(hspace: .image, value: 15)
        .config(button: { (item) in
          item.backgroundColor = UIColor(hex: "#0180bf")
          item.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        })
        .set(image: UIImage(named: "empty-1002")!)
        .set(title: "Connection failure",
             color: UIColor.black,
             font: UIFont.boldSystemFont(ofSize: 24))
        .set(text: "Something has gone wrong with the internet connection. Let's give it another shot.",
             color: UIColor.black,
             font: UIFont.systemFont(ofSize: 15))
        .set(buttonTitle: "TRY AGAIN")
        .set(tap: alertEvent())
        .mix()
      let item = CellItem(title: "emptystat.es",
                          subTitle: "http://emptystat.es/image/162198623343",
                          emptyView: emptyView)
      items.append(item)
    }
    
    sections.append(Section(title: "emptystat.es",items: items))
  }
  
  func buildByDribbble() {
    var items = [CellItem]()
    if true {
      // https://dribbble.com/shots/2586577-404-page-Illustration
      let emptyView = EmptyPageView.ContentView.standard
        .set(image: UIImage(named: "404")!)
        .change(vspace: .titleWithText, value: 0)
        .set(title: "FILE NOT FOUND",
             color: UIColor(hex: "#849aac"),
             font: UIFont.boldSystemFont(ofSize: 18))
        .set(text: "Lorem ipsum dolor sit amet.\nconectetur adipscing elit sed do eiusmod",
             color: UIColor(hex: "#c5cfd7"))
        .config(button: { (item) in
          item.isHidden = true
        })
        .set(tap: alertEvent())
        .mix()
        .set(backgroundColor: UIColor(hex: "#f5f7f9"))
      let item = CellItem(title: "404 page - Illustration",
                          subTitle: "https://dribbble.com/iftikharshaikh",
                          emptyView: emptyView)
      items.append(item)
    }
    
    sections.append(Section(title: "dribbble",items: items))
  }
  
  func buildSectionForCustom() {
    var items = [CellItem]()
    if true {
      let view = EmptyPageForCustom.initFromNib
      view.imageView.image = UIImage(named: "empty")
      view.label.text = "Connection failure"
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
    
    let attributed = NSMutableAttributedString(string: "Connection",
                                               attributes: [.font : UIFont.boldSystemFont(ofSize: 30),
                                                            .foregroundColor: UIColor.red])
    let attributed2 = NSAttributedString(string: " Failure",
                                         attributes: [.font : UIFont.systemFont(ofSize: 20),
                                                      .foregroundColor: UIColor.darkText])
    attributed.append(attributed2)
    
    if true {
      let emptyView = EmptyPageView.ContentView.onlyText.set(text: "Connection failure").mix()
      let item = CellItem(title: "纯文字", subTitle: "默认样式", emptyView: emptyView)
      items.append(item)
    }
    
    if true {
      let emptyView = EmptyPageView.ContentView.onlyText.set(attributed: attributed).mix()
      let item = CellItem(title: "纯文字", subTitle: "富文本样式", emptyView: emptyView)
      items.append(item)
    }
    
    if true {
      let emptyView = EmptyPageView.ContentView.onlyImage
        .set(image: UIImage(named: "empty-1002")!)
        .change(hspace: .image, value: 10)
        .mix()
      let item = CellItem(title: "纯图片", subTitle: "默认样式", emptyView: emptyView)
      items.append(item)
    }
    
    if true {
      let emptyView = EmptyPageView.ContentView.onlyImage
        .set(images: images, duration: 1.5, repeatCount: 0)
        .mix()
      let item = CellItem(title: "纯图片", subTitle: "图片组样式", emptyView: emptyView)
      items.append(item)
    }
    
    
    if true {
      let emptyView = EmptyPageView.ContentView.standard
        .set(image: UIImage(named: "empty")!)
        .set(title: "Connection failure")
        .set(text: "wait for a minture")
        .set(buttonTitle: "Try Again")
        .change(hspace: .button, value: 40)
        .change(vspace: .textWithButton, value: 10)
        .set(tap: alertEvent())
        .mix()
      
      let item = CellItem(title: "标准", subTitle: "默认样式", emptyView: emptyView)
      items.append(item)
    }
    
    if true {
      let emptyView = EmptyPageView.ContentView.standard
        .config(button: { (item) in
          item.setTitleColor(.white, for: .normal)
          item.titleLabel?.font = .boldSystemFont(ofSize: 18)
          item.backgroundColor = .darkGray
        })
        .set(images: images, duration: 1.5, repeatCount: 0)
        .set(titleAttributed: attributed)
        .set(textAttributed: attributed)
        .set(text: "wait for a minture")
        .set(buttonTitle: "按钮文本")
        .set(tap: alertEvent())
        .mix()
      
      let item = CellItem(title: "标准", subTitle: "默认样式", emptyView: emptyView)
      items.append(item)
    }
    sections.append(Section(title: "标准样式",items: items))
  }
  
  func alertEvent() -> (() -> ()) {
    return {
      let alert = UIAlertController(title: "点击事件",message: nil,preferredStyle: .alert)
      let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
      alert.addAction(action)
      UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
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
    let item = sections[indexPath.section].items[indexPath.item]
    switch item.subTitle {
    case "tableView":
      let vc = DemoTableViewController(style: .plain)
      navigationController?.pushViewController(vc, animated: true)
    case "collectionView":
      let vc = DemoCollectionViewController()
      navigationController?.pushViewController(vc, animated: true)
    case "scrollView":
      let vc = DemoScrollViewController()
      navigationController?.pushViewController(vc, animated: true)
    default:
      let vc = UITableViewController(style: .plain)
      vc.tableView.separatorStyle = .none
      vc.tableView.setEmpty(view: item.emptyView)
      navigationController?.pushViewController(vc, animated: true)
    }
    
  }
  
  
}
