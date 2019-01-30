//
//  DZDetailViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/1/25.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

/// from: https://github.com/dzenbot/DZNEmptyDataSet
class DZDetailViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
  }
  
  func config(nav title: String, barColor: UIColor, tintColor: UIColor, image: UIImage? = nil) {
    self.navigationController?.navigationBar.titleTextAttributes = nil
    
    if let image = image {
      self.navigationItem.titleView = UIImageView(image: image)
    }else{
      self.navigationItem.titleView = nil
      self.navigationItem.title = title
    }
    
    self.navigationController?.navigationBar.barTintColor = barColor
    self.navigationController?.navigationBar.tintColor = tintColor
  }
  
  func config(emptyPage: EmptyPageView) {
    tableView.setEmpty(view: emptyPage)
  }
  
}
