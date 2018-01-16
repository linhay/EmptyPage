//
//  HomeViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/1/12.
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
    title = "EmptyPage"
    tableView.rowHeight = 50
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.sectionHeaderHeight = 40
    buildDemos()
    buildSectionForDefault()
    buildSectionForCustom()
    // buildByDribbble() // 还没申请授权
    buildByEmptystat()
  }

  func buildDemos() {
    let table = CellItem(title: "tableView示例", subTitle: "tableView", emptyView: EmptyPageView())
    let collection = CellItem(title: "collectionView示例", subTitle: "collectionView", emptyView: EmptyPageView())
    /// 还没找到判断subviews移除的判断依据.
    // let scroll = CellItem(title: "scrollView示例", subTitle: "scrollView", emptyView: EmptyPageView())
    sections.append(Section(title: "完整示例", items: [table,collection]))
  }


  func buildByEmptystat() {
    var items = [CellItem]()

    if true {
      // http://emptystat.es/image/167120251047
      let view = EmptyPageView.ContentView.standard
      view.configImageView(images: [UIImage(named: "empty-1001")!])
      let emptyView: EmptyPageView = .mix(view: view)
      emptyView.backgroundColor = .white
      view.titleLabel.text = "Nobody is following"
      view.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
      view.titleLabel.textColor = UIColor(red: 130 / 255,
                                          green: 151 / 255,
                                          blue: 172 / 255,
                                          alpha: 1)
      view.textLabel.text = "Following people helps you keep what they're saying and recommending."
      view.textLabel.textColor = UIColor(red: 176 / 255,
                                         green: 190 / 255,
                                         blue: 203 / 255,
                                         alpha: 1)

      let buttonColor = UIColor(red: 50 / 255,
                                green: 160 / 255,
                                blue: 255 / 255,
                                alpha: 1)

      view.button.layer.borderColor = buttonColor.cgColor
      view.button.layer.borderWidth = 1
      view.button.layer.cornerRadius = 5
      view.button.setTitle("Find interesting people to follow >>", for: .normal)
      view.button.backgroundColor = .white
      view.button.setTitleColor(buttonColor, for: .normal)
      view.button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
      let item = CellItem(title: "emptystat.es",
                          subTitle: "http://emptystat.es/image/167120251047",
                          emptyView: emptyView)
      items.append(item)
    }

    if true {
      // http://emptystat.es/image/162198623343
      let view = EmptyPageView.ContentView.standard
      view.configImageView(images: [UIImage(named: "empty-1002")!])
      let emptyView: EmptyPageView = .mix(view: view)
      view.titleLabel.text = "Connection failure"
      view.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
      view.titleLabel.textColor = UIColor(red: 130 / 255,
                                          green: 151 / 255,
                                          blue: 172 / 255,
                                          alpha: 1)
      view.textLabel.text = "Something has gone wrong with the internet connection. Let's give it another shot."

      view.button.setTitle("TRY AGAIN", for: .normal)
      view.button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
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
      let view = EmptyPageView.ContentView.standard
      view.imageAspect = 457 / 285
      view.imageView.image = UIImage(named: "404")
      let emptyView: EmptyPageView = .mix(view: view)
      emptyView.backgroundColor = UIColor(red: 244 / 255,
                                          green: 247 / 255,
                                          blue: 249 / 255,
                                          alpha: 1)

      view.titleLabel.text = "FILE NOT FOUND"
      view.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
      view.titleLabel.textColor = UIColor(red: 130 / 255,
                                          green: 151 / 255,
                                          blue: 172 / 255,
                                          alpha: 1)
      view.titleWithTextSpace = 0
      view.textLabel.text = """
      Lorem ipsum dolor sit amet.
      conectetur adipscing elit sed do eiusmod
      """

      view.textLabel.textColor = UIColor(red: 176 / 255,
                                         green: 190 / 255,
                                         blue: 203 / 255,
                                         alpha: 1)
      view.button.isHidden = true
      let item = CellItem(title: "404 page - Illustration",
                          subTitle: "https://dribbble.com/iftikharshaikh",
                          emptyView: emptyView)
      items.append(item)
    }

    if true {
      // http://emptystat.es/image/162198623343
      let view = EmptyPageView.ContentView.standard
      view.configImageView(images: [UIImage(named: "404")!])
      let emptyView: EmptyPageView = .mix(view: view)
      emptyView.backgroundColor = UIColor(red: 244 / 255,
                                          green: 247 / 255,
                                          blue: 249 / 255,
                                          alpha: 1)

      view.titleLabel.text = "FILE NOT FOUND"
      view.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
      view.titleLabel.textColor = UIColor(red: 130 / 255,
                                          green: 151 / 255,
                                          blue: 172 / 255,
                                          alpha: 1)
      view.titleWithTextSpace = 0
      view.textLabel.text = """
      Lorem ipsum dolor sit amet.
      conectetur adipscing elit sed do eiusmod
      """

      view.textLabel.textColor = UIColor(red: 176 / 255,
                                         green: 190 / 255,
                                         blue: 203 / 255,
                                         alpha: 1)
      view.button.isHidden = true
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
      let item = CellItem(title: "纯文字",
                          subTitle: "默认样式",
                          emptyView: .onlyText(text: "Connection failure"))
      items.append(item)
    }
    
    if true {
      let item = CellItem(title: "纯文字",
                          subTitle: "富文本样式",
                          emptyView: .onlyText(attributed: attributed))
      items.append(item)
    }
    
    if true {
      let item = CellItem(title: "纯图片",
                          subTitle: "默认样式",
                          emptyView: .onlyImage(image: UIImage(named: "empty")!))
      items.append(item)
    }
    
    if true {
      let item = CellItem(title: "纯图片",
                          subTitle: "图片组样式",
                          emptyView: .onlyImages(images: images,
                                                 duration: 1.5,
                                                 repeatCount: 0))
      items.append(item)
    }
    
    
    if true {
      let item = CellItem(title: "标准",
                          subTitle: "默认样式",
                          emptyView: .standard(images: [UIImage(named: "empty")!],
                                               title: "Connection failure",
                                               text: "wait for a minture",
                                               btnTitle: "Try Again",
                                               event: {
                                                self.alertEvent()
                          }))
      items.append(item)
    }
    
    if true {
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
