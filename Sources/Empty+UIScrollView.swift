//
//  Empty+UIScrollView.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public extension UIScrollView {
  
  private struct EmptyDataKey {
    static let emptyViewKey = UnsafeRawPointer(bitPattern:"scroll_emptyViewKey".hashValue)!
    static let oldEmptyViewKey = UnsafeRawPointer(bitPattern:"scroll_oldEmptyViewKey".hashValue)!
  }
  
  weak var oldEmptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.oldEmptyViewKey) as? UIView
    }
    set {
      // 防止多次设置emptyView
      if oldEmptyView?.superview != nil { return }
      if let emptyView: AnyObject = newValue {
        objc_setAssociatedObject(self,EmptyDataKey.oldEmptyViewKey,emptyView,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
  public var emptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.emptyViewKey) as? UIView
    }
    set {
      if let emptyView: AnyObject = newValue {
        self.oldEmptyView = self.emptyView
        objc_setAssociatedObject(self,EmptyDataKey.emptyViewKey,emptyView,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
}
