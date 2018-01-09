//
//  Empty+UICollectionView.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/9.
//

import UIKit

public extension UICollectionView {
  
  private struct EmptyDataKey {
    static let emptyViewKey  = UnsafeRawPointer(bitPattern:"coll_emptyViewKey".hashValue)!
  }
  
  public var emptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.emptyViewKey) as? UIView
    }set {
      if let emptyView: AnyObject = newValue {
        objc_setAssociatedObject(self,EmptyDataKey.emptyViewKey,emptyView,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
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
    emptyView?.removeFromSuperview()

    
    if isHasRows {
      self.coll_emptyReloadData()
      return
    }
    
    guard let view = emptyView else { return }
    view.frame = bounds
    addSubview(view)
  }
  
}

