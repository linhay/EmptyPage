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

fileprivate struct EmptyDataKey {
    static let emptyViewKey = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.emptyView".hashValue)!
    static let oldEmptyViewKey = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.oldEmptyView".hashValue)!
    static let oldIsScrollEnabledKey = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.oldIsScrollEnabledKey".hashValue)!
}


extension UIScrollView {
    
    var oldIsScrollEnabled: Bool {
        get { return objc_getAssociatedObject(self,EmptyDataKey.oldEmptyViewKey) as? Bool ?? self.isScrollEnabled }
        set { objc_setAssociatedObject(self,EmptyDataKey.oldEmptyViewKey,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // 私有属性 (多次赋值emptyView时,防止多个emptyView同时出现)
    weak var oldEmptyView: UIView? {
        get { return objc_getAssociatedObject(self,EmptyDataKey.oldEmptyViewKey) as? UIView }
        set {
            // 防止多次设置emptyView
            if oldEmptyView?.superview != nil { return }
            if let emptyView: AnyObject = newValue {
                objc_setAssociatedObject(self,EmptyDataKey.oldEmptyViewKey,emptyView,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    // 空白页视图
    var emptyView: UIView? {
        get {
            return objc_getAssociatedObject(self,EmptyDataKey.emptyViewKey) as? UIView
        }
        set {
            self.oldEmptyView = self.emptyView
            
            if newValue != nil {
                EmptyPageRuntime.swizzingLayout
                /// 兼容子类化情况
                if self.isKind(of: UITableView.self) {
                    EmptyPageRuntime.swizzingTableView
                } else if self.isKind(of: UICollectionView.self) {
                    EmptyPageRuntime.swizzingCollectionView
                }else {
                    
                }
            }else{
                emptyView?.removeFromSuperview()
                self.oldEmptyView = nil
            }
            
            objc_setAssociatedObject(self,EmptyDataKey.emptyViewKey,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension UIScrollView {
    
    fileprivate var isEmpty: Bool {
        return subviews.filter({ $0 !== self.emptyView && $0 !== oldEmptyView }).count == 0
    }
    
    
    func setEmptyView(_ isEmpty: Bool) {
        self.oldEmptyView?.removeFromSuperview()
        
        guard isEmpty else {
            isScrollEnabled = oldIsScrollEnabled
            emptyView?.removeFromSuperview()
            return
        }
        
        oldIsScrollEnabled = isScrollEnabled
        isScrollEnabled = isEmpty
        
        guard let view = emptyView else{ return }
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view.removeFromSuperview()
        addSubview(view)
        
        #if swift(>=4.2)
        sendSubviewToBack(view)
        #else
        sendSubview(toBack: view)
        #endif
    }
    
}

public extension EmptyPage where Base: UIScrollView {
    
    func setEmpty(_ view: UIView?) {
        base.emptyView = view
    }
    
    /// 空白页视图
    var emptyView: UIView? {
        set { base.emptyView = newValue }
        get { return base.emptyView }
    }
    
}

extension UIScrollView {
    
    @objc func emptyPage_layoutSubviews() {
        emptyPage_layoutSubviews()
        guard let emptyView = self.ep.emptyView else { return }
        emptyView.frame = bounds
    }
    
    @objc func emptyPage_layoutIfNeeded() {
        emptyPage_layoutIfNeeded()
        guard let emptyView = self.ep.emptyView else { return }
        emptyView.frame = bounds
    }
    
}
