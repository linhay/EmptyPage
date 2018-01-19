//
//  Empty+UICollectionView.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

extension UICollectionView {
  
  @objc func coll_emptyLayoutSubviews() {
    coll_emptyLayoutSubviews()
    emptyView?.frame = bounds
  }
  
  @objc func coll_emptyLayoutIfNeeded() {
    coll_emptyLayoutIfNeeded()
    emptyView?.frame = bounds
  }
  
  @objc func coll_emptyInsertItems(at indexPaths: [IndexPath]){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyInsertItems(at: indexPaths)
    }
  }
  
  @objc func coll_emptyDeleteItems(at indexPaths: [IndexPath]){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyDeleteItems(at: indexPaths)
    }
  }
  
  @objc func coll_emptyInsertSections(_ sections: IndexSet){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyInsertSections(sections)
    }
  }
  
  @objc func coll_emptyDeleteSections(_ sections: IndexSet){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyDeleteSections(sections)
    }
  }
  
  @objc func coll_emptyReloadData() {
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyReloadData()
    }
  }
  
  func setEmptyView(event: () -> ()) {
    oldEmptyView?.removeFromSuperview()
    event()
    guard bounds.width != 0, bounds.height != 0 else { return }
    var isHasRows = false
    let sectionCount = dataSource?.numberOfSections?(in: self) ?? numberOfSections
    for index in 0..<sectionCount {
      if numberOfItems(inSection: index) > 0 {
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

