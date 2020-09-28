//
//  EmptyPage
//
//  Copyright (c) 2018 linhey - https://github.com/linhay
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

public extension EmptyPage where Base: UICollectionView {

    /// 空白页管理器
    var manager: EmptyPageCollectionViewManager? {
        if base.useCustomManager {
            return base.emptyPageViewManager as? EmptyPageCollectionViewManager
        }

        if base.emptyPageViewManager == nil {
            if let placeholder = EmptyPageConfiguration.shared.collectionViewGloalManager {
                set(manager: placeholder)
            } else {
                set(manager: EmptyPageCollectionViewManager())
            }
        }

        return base.emptyPageViewManager as? EmptyPageCollectionViewManager
    }

    /// 当显示空白页时页面是否可以滚动 | default: false
    var canScrollEnabled: Bool {
        set { manager?.canScrollEnabled = newValue }
        get { manager?.canScrollEnabled ?? false }
    }

    /// 设置当前 View 的空白页管理器
    /// - Parameter manager: 空白页管理器
    func set(manager: EmptyPageViewManager?) {
        EmptyPageRuntime.swizzingCollectionView
        base.useCustomManager = true
        base.emptyPageViewManager = manager
        manager?.set(target: base)
    }

    /// 设置当前 View 的空白页
    /// - Parameter view: 自定义空白页
    func set(emptyView view: UIView?) {
        EmptyPageRuntime.swizzingCollectionView
        manager?.set(emptyView: view)
    }

}
