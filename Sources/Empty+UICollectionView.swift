//
//  Empty+UICollectionView.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/9.
//

import UIKit

public extension UICollectionView {
  
  @objc func coll_emptyReloadData() {
    if frame.size.width == 0 || frame.size.height == 0 { return }
    guard let dataSource = dataSource else { return }
    guard let sectionCount = dataSource.numberOfSections?(in: self) else { return }
    
    var isHasRows = false
    for index in 0 ..< sectionCount {
      if dataSource.collectionView(self, numberOfItemsInSection: index) != 0 {
        isHasRows = true
        break
      }
    }
    
    isScrollEnabled = isHasRows
    oldEmptyView?.removeFromSuperview()

    if isHasRows {
      emptyView?.removeFromSuperview()
      coll_emptyReloadData()
      return
    }

    coll_emptyReloadData()
    guard let view = emptyView else { return }
    view.frame = bounds
    addSubview(view)
  }

  
}

