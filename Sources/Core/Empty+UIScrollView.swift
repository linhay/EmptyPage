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

extension UIScrollView {

    fileprivate struct EmptyDataKey {
        static let emptyView = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.emptyView".hashValue)!
        static let isSetedEmptyView = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.isSetedEmptyView".hashValue)!
        static let oldEmptyView = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.oldEmptyView".hashValue)!
        static let firstLoadingView = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.firstLoadingView".hashValue)!
        static let isSetedFirstLoadingView = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.isSetedFirstLoadingView".hashValue)!
        static let oldIsScrollEnabled = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.oldIsScrollEnabled".hashValue)!
        static let isFirstLoading = UnsafeRawPointer(bitPattern:"EmptyPage.UIScrollView.isFirstLoading".hashValue)!
    }

    /// 是否手动设置过 空白页
    var isSetedEmptyView: Bool {
        get { return objc_getAssociatedObject(self,EmptyDataKey.isSetedEmptyView) as? Bool ?? false }
        set { objc_setAssociatedObject(self,EmptyDataKey.isSetedEmptyView,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    /// 是否手动设置过 加载空白页
    var isSetedFirstLoadingView: Bool {
        get { return objc_getAssociatedObject(self,EmptyDataKey.isSetedFirstLoadingView) as? Bool ?? false }
        set { objc_setAssociatedObject(self,EmptyDataKey.isSetedFirstLoadingView,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    var oldIsScrollEnabled: Bool {
        get { return objc_getAssociatedObject(self,EmptyDataKey.oldEmptyView) as? Bool ?? self.isScrollEnabled }
        set { objc_setAssociatedObject(self,EmptyDataKey.oldEmptyView,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    // 私有属性 (多次赋值emptyView时,防止多个emptyView同时出现)
    weak var oldEmptyView: UIView? {
        get { return objc_getAssociatedObject(self,EmptyDataKey.oldEmptyView) as? UIView }
        set {
            // 防止多次设置emptyView
            if oldEmptyView?.superview != nil { return }
            if let emptyView: AnyObject = newValue {
                objc_setAssociatedObject(self,EmptyDataKey.oldEmptyView,emptyView,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    // 空白页视图
    var emptyView: UIView? {
        get {
            if !isSetedEmptyView, let view = EmptyPageConfig.shared.emptyView?(self) {
                self.emptyView = view
                return view
            }

            return objc_getAssociatedObject(self,EmptyDataKey.emptyView) as? UIView
        }
        set {
            self.isSetedEmptyView = true

            if self.emptyView !== newValue {
                self.oldEmptyView = self.emptyView
            }

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
            
            objc_setAssociatedObject(self,EmptyDataKey.emptyView,newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// 是否是第一次 展示 EmptyView
    var isFirstLoading: Bool {
        get { return objc_getAssociatedObject(self,EmptyDataKey.isFirstLoading) as? Bool ?? true }
        set { objc_setAssociatedObject(self,EmptyDataKey.isFirstLoading,
                                       newValue,
                                       .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// 第一次 reload 采用的空白页(可用于加载loading)
    var firstLoadingView: UIView? {
        get {
            if !isSetedFirstLoadingView, let view = EmptyPageConfig.shared.firstLoadingView?(self) {
                self.firstLoadingView = view
                return view
            }

            return objc_getAssociatedObject(self,EmptyDataKey.firstLoadingView) as? UIView
        }
        set {
            self.isSetedFirstLoadingView = true
            objc_setAssociatedObject(self,EmptyDataKey.firstLoadingView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension UIScrollView {
    
    @objc var isEmpty: Bool {
        return subviews.first(where: { $0 !== self.emptyView && $0 !== oldEmptyView && $0 !== firstLoadingView }) == nil
    }
    
    func setEmptyView(_ isEmpty: Bool) {
        self.oldEmptyView?.removeFromSuperview()
        
        guard isEmpty else {
            isScrollEnabled = oldIsScrollEnabled
            firstLoadingView?.removeFromSuperview()
            emptyView?.removeFromSuperview()
            return
        }
        
        oldIsScrollEnabled = isScrollEnabled
        isScrollEnabled = isEmpty

        var emptyView: UIView? = nil

        if isFirstLoading, let firstView = firstLoadingView {
            emptyView = firstView
            isFirstLoading = false
        }else{
            firstLoadingView?.removeFromSuperview()
            firstLoadingView = nil
            emptyView = self.emptyView
        }

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

    /// 设置 空白页视图
    /// - Parameter view: 空白页视图
    func setEmpty(_ view: UIView?) {
        base.emptyView = view
    }

    /// 设置 第一次 reload 采用的空白页(可用于加载loading)
    /// - Parameter view: 空白页视图
    func setFirstLoading(_ view: UIView?) {
        base.firstLoadingView = view
    }

    /// 替换空白页视图
    /// - Parameter view: 空白页视图
    func replace(by view: UIView?) {
        base.emptyView = view
        base.setEmptyView(base.isEmpty)
    }

    /// 空白页视图
    var emptyView: UIView? {
        set { base.emptyView = newValue }
        get { return base.emptyView }
    }

    /// 第一次 reload 采用的空白页(可用于加载loading)
    var firstLoadingView: UIView? {
        set { base.firstLoadingView = newValue }
        get { return base.firstLoadingView }
    }
    
}

extension UIScrollView {
    
    @objc func emptyPage_layoutSubviews() {
        emptyPage_layoutSubviews()
        if let emptyView = self.ep.firstLoadingView { emptyView.frame = bounds }
        else if let emptyView = self.ep.emptyView { emptyView.frame = bounds }
    }
    
    @objc func emptyPage_layoutIfNeeded() {
        emptyPage_layoutIfNeeded()
        if let emptyView = self.ep.firstLoadingView { emptyView.frame = bounds }
        else if let emptyView = self.ep.emptyView { emptyView.frame = bounds }
    }
    
}
