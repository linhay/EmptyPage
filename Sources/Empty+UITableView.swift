//
//  TableView+Empty.swift
//  B7iOSShop
//
//  Created by BigL on 2016/12/9.
//  Copyright © 2016年 spzjs.b7iosshop.com. All rights reserved.
//

import UIKit

public extension UITableView {

  private struct EmptyDataKey {
    static let emptyViewKey  = UnsafeRawPointer(bitPattern: "table_emptyViewKey".hashValue)!
  }


  public var emptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,
                                      UITableView.EmptyDataKey.emptyViewKey) as? UIView
    }set {
      if let emptyView: AnyObject = newValue {
        objc_setAssociatedObject(self,
                                 UITableView.EmptyDataKey.emptyViewKey,
                                 emptyView,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }


  @objc func table_emptyReloadData() {

    if estimatedRowHeight == -1 { estimatedRowHeight = 0 }
    if estimatedSectionFooterHeight == -1 { estimatedSectionFooterHeight = 0 }
    if estimatedSectionHeaderHeight == -1 { estimatedSectionHeaderHeight = 0 }

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
    emptyView?.removeFromSuperview()


    if isHasRows {
      self.table_emptyReloadData()
      return
    }

    guard let view = emptyView else { return }
    view.frame = bounds
    addSubview(view)

  }
}
