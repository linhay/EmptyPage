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
    
    private enum EmptyDataKey {
        static let emptyView = UnsafeRawPointer(bitPattern: "EmptyPage.UIScrollView.ep.emptyView".hashValue)!
        static let ep_isScrollEnabled = UnsafeRawPointer(bitPattern: "EmptyPage.UIScrollView.ep.isScrollEnabled".hashValue)!
        static let ep_canScrollEnabled = UnsafeRawPointer(bitPattern: "EmptyPage.UIScrollView.ep.canScrollEnabled".hashValue)!
        static let ep_supplementaryView = UnsafeRawPointer(bitPattern: "EmptyPage.UIScrollView.ep.supplementaryView".hashValue)!
    }
    
    // swiftlint:disable implicit_getter
    var ep_isScrollEnabled: Bool {
        set { objc_setAssociatedObject(self, EmptyDataKey.ep_isScrollEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { return objc_getAssociatedObject(self, EmptyDataKey.ep_isScrollEnabled) as? Bool ?? self.isScrollEnabled }
    }
    
    var ep_canScrollEnabled: Bool {
        set { objc_setAssociatedObject(self, EmptyDataKey.ep_canScrollEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { return objc_getAssociatedObject(self, EmptyDataKey.ep_canScrollEnabled) as? Bool ?? false }
    }
    
    var ep_supplementaryView: [UIView.Type] {
        set { objc_setAssociatedObject(self, EmptyDataKey.ep_supplementaryView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { return objc_getAssociatedObject(self, EmptyDataKey.ep_supplementaryView) as? [UIView.Type] ?? [] }
    }
    
    // 空白页视图
    var emptyView: UIView? {
        get {
            return objc_getAssociatedObject(self, EmptyDataKey.emptyView) as? UIView
        }
        set {
            EmptyPageRuntime.swizzingLayout
            if self.isKind(of: UITableView.self) {
                EmptyPageRuntime.swizzingTableView
            } else if self.isKind(of: UICollectionView.self) {
                EmptyPageRuntime.swizzingCollectionView
            } else if self.isKind(of: UIScrollView.self) {
                EmptyPageRuntime.swizzingScrollView
            }
            objc_setAssociatedObject(self, EmptyDataKey.emptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    // swiftlint:enable implicit_getter
    
}

extension UIScrollView {
    
    func reloadEmptyView(isEmpty: Bool = false) {
        if isEmpty, emptyView?.superview == nil {
            ep_isScrollEnabled = isScrollEnabled
        }
        isEmpty ? showEmptyView() : hideEmptyView()
    }
    
    private func showEmptyView() {
        guard let view = emptyView else {
            isScrollEnabled = ep_isScrollEnabled
            return
        }
        
        isScrollEnabled = ep_canScrollEnabled
        
        view.frame = bounds
        if view.superview !== self {
            view.removeFromSuperview()
            addSubview(view)
        }
        
        #if swift(>=4.2)
        sendSubviewToBack(view)
        #else
        sendSubview(toBack: view)
        #endif
    }
    
    private func hideEmptyView() {
        emptyView?.removeFromSuperview()
        isScrollEnabled = ep_isScrollEnabled
    }
    
    func setEmptyView(_ view: UIView?) {
        guard let view = view else {
            isScrollEnabled = ep_isScrollEnabled
            emptyView?.removeFromSuperview()
            return
        }
        
        if emptyView !== view {
            emptyView?.removeFromSuperview()
        }
        
        emptyView = view
        reloadEmptyView()
    }
    
}

// MARK: - layoutSubviews
extension UIScrollView {
    
    private func reSizeEmptyPage(function: String = #function) {
        guard let view = emptyView, view.superview != nil, view.frame != bounds else {
            return
        }
        view.frame = bounds
    }
    
    @objc func emptyPage_layoutSubviews() {
        emptyPage_layoutSubviews()
        reSizeEmptyPage()
    }
    
    @objc func emptyPage_layoutIfNeeded() {
        emptyPage_layoutIfNeeded()
        reSizeEmptyPage()
    }
    
}
