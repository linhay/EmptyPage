//
//  Empty+UITableView.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.


import UIKit

public extension UITableView {

  @objc func table_emptyLayoutSubviews() {
    table_emptyLayoutSubviews()
    guard let emptyView = emptyView, bounds != emptyView.frame else{ return }
    emptyView.frame = bounds
  }

  @objc func table_emptyInsertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyInsertRows(at: indexPaths, with: animation)
    }
  }

  @objc func table_emptyDeleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyDeleteRows(at: indexPaths, with: animation)
    }
  }

  @objc func table_emptyInsertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyInsertSections(sections, with: animation)
    }
  }

  @objc func table_emptyDeleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyDeleteSections(sections, with: animation)
    }
  }

  @objc func table_emptyReloadData() {
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyReloadData()
    }
  }

  func setEmptyView(event: () -> ()) {
    if frame.size.width == 0 || frame.size.height == 0 {
      event()
      return
    }

    guard let dataSource = dataSource,
     let sectionCount = dataSource.numberOfSections?(in: self) else {
      event()
      return
    }

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
      event()
      return
    }

    event()
    guard let view = emptyView else { return }
    view.frame = bounds
    addSubview(view)
  }
}
