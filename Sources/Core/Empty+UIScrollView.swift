//
//  EmptyPage
//
//  Copyright (c) 2018 linhay - https://github.com/linhay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

import UIKit

public extension UIScrollView {
  
  private struct EmptyDataKey {
    static let emptyViewKey = UnsafeRawPointer(bitPattern:"scroll_emptyViewKey".hashValue)!
    static let oldEmptyViewKey = UnsafeRawPointer(bitPattern:"scroll_oldEmptyViewKey".hashValue)!
  }
  
  // 私有属性 (防止多次设置emptyView)
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
  
  
  // 空白页视图
  public var emptyView: UIView? {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.emptyViewKey) as? UIView
    }
    set {
      if let emptyView: AnyObject = newValue {
        self.oldEmptyView = self.emptyView
        
        if self.isMember(of: UIScrollView.self) {
          EmptyPage.swizzingScrollView
        } else if self.isMember(of: UITableView.self) {
          EmptyPage.swizzingTableView
        } else if self.isMember(of: UICollectionView.self) {
          EmptyPage.swizzingCollectionView
        }else {
          
        }
        
        objc_setAssociatedObject(self,EmptyDataKey.emptyViewKey,emptyView,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }else{
        emptyView?.removeFromSuperview()
        self.oldEmptyView = nil
        objc_setAssociatedObject(self,EmptyDataKey.emptyViewKey,nil,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
  
  
  @objc func emptyPage_addSubview(_ view: UIView) {
    emptyPage_addSubview(view)
    if !self.isMember(of: UIScrollView.self) || view === emptyView { return }
    emptyView?.removeFromSuperview()
    oldEmptyView?.removeFromSuperview()
  }
  
  @objc func emptyPage_willRemoveSubview(_ view: UIView) {
    emptyPage_willRemoveSubview(view)
    if !self.isMember(of: UIScrollView.self) || view === emptyView { return }
    oldEmptyView?.removeFromSuperview()
    guard bounds.width != 0, bounds.height != 0 else { return }
    let isEmpty = subviews.filter { $0 !== view }.count == 0

    isScrollEnabled = isEmpty
    
    guard isEmpty else {
      emptyView?.removeFromSuperview()
      return
    }
    
    guard let view = emptyView else{ return }
    view.frame = bounds
    addSubview(view)
    
    #if swift(>=4.2)
    sendSubviewToBack(view)
    #else
    sendSubview(toBack: view)
    #endif
    
  }
  
}
