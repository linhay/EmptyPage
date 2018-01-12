//
//  Empty+UITableView.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.


import UIKit

public extension UITableView {

  @objc func table_emptyReloadData() {

    if frame.size.width == 0 || frame.size.height == 0 {
      self.table_emptyReloadData()
      return
    }

    guard let dataSource = dataSource else { return }
    guard let sectionCount = dataSource.numberOfSections?(in: self) else { return }

    var isHasRows = false
    for index in 0 ..< sectionCount {
      if dataSource.tableView(self, numberOfRowsInSection: index) != 0 {
        isHasRows = true
        break
      }
    }

    isScrollEnabled = isHasRows
    oldEmptyView?.removeFromSuperview()

    if isHasRows {
      emptyView?.removeFromSuperview()
      table_emptyReloadData()
      return
    }

    table_emptyReloadData()
    guard let view = emptyView else { return }
    view.frame = bounds
    addSubview(view)

  }
}
