//
//  Empty+UITableView.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.


import UIKit

 extension UITableView {

  @objc func table_emptyLayoutSubviews() {
    table_emptyLayoutSubviews()
    emptyView?.frame = bounds
  }

  @objc func table_emptyLayoutIfNeeded() {
    table_emptyLayoutIfNeeded()
    emptyView?.frame = bounds
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
    oldEmptyView?.removeFromSuperview()
    event()
    guard bounds.width != 0, bounds.height != 0 else { return }
    var isHasRows = false
    let sectionCount = dataSource?.numberOfSections?(in: self) ?? numberOfSections
    for index in 0..<sectionCount {
      if numberOfRows(inSection: index) > 0 {
        isHasRows = true
        break
      }
    }
    isScrollEnabled = isHasRows
    if isHasRows {
      emptyView?.removeFromSuperview()
      return
    }
    guard let view = emptyView else{ return }
    view.frame = bounds
    addSubview(view)
  }
}
