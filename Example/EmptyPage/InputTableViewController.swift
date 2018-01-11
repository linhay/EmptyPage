//
//  InputTableViewController.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

class InputTableViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    EmptyPage.begin()
  }

  @IBAction func onlyTextEvent(_ sender: UIButton) {
    let vc = UITableViewController(style: .plain)
    vc.tableView.setEmpty(view: .onlyText(style: .title, text: "没有更多信息了"))
    vc.tableView.separatorStyle = .none
    navigationController?.pushViewController(vc, animated: true)
  }

  
  @IBAction func onlyImagesEvent(_ sender: Any) {
    let vc = UITableViewController(style: .plain)
    let images = (0...3).map { (item) -> UIImage in
      return UIImage(named: "load-\(item)")!
    }
    vc.tableView.setEmpty(view: .onlyImages(images: images,duration: 1.5, repeatCount: 0))
    vc.tableView.separatorStyle = .none
    navigationController?.pushViewController(vc, animated: true)
  }

  @IBAction func standardEvent(_ sender: UIButton) {
    let vc = UITableViewController(style: .plain)
    let emptyView = EmptyPageView.standard(image: UIImage(named: "empty")!, title: "title", text: "text", btnTitle: "btnTitle") {
      let alert = UIAlertController(title: "standard", message: nil, preferredStyle: .alert)
      let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
      alert.addAction(action)
      vc.present(alert, animated: true, completion: nil)
    }

    vc.tableView.setEmpty(view: emptyView)
    vc.tableView.separatorStyle = .none
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func standardLoadEvent(_ sender: UIButton) {
    let vc = UITableViewController(style: .plain)
    let images = (0...3).map { (item) -> UIImage in
      return UIImage(named: "load-\(item)")!
    }
    
    let emptyView = EmptyPageView.standard(images: images,duration: 1.5,repeatCount: 0,title: "标题",text: "空白页描述",btnTitle: "点击试试") {
      let alert = UIAlertController(title: "standard", message: nil, preferredStyle: .alert)
      let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
      alert.addAction(action)
      vc.present(alert, animated: true, completion: nil)
    }

    vc.tableView.setEmpty(view: emptyView)
    vc.tableView.separatorStyle = .none
    navigationController?.pushViewController(vc, animated: true)
  }
  
}
