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

public extension EmptyPage where Base: UIView {

    /// 空白页视图
    var emptyView: UIView? {
        return base.emptyPageViewManager?.view
    }

    /**
     空白页是否显示

     - Authors: linhey
     - Date: 2020/04/22

     - Example:

     ```

     scrollView.ep.isShow

     ```
     */
    var isShow: Bool {
        emptyView?.superview === base
    }

    /**
     主动触发空白页视图显示逻辑,

     - Authors: linhey
     - Date: 2020/04/22
     - Example:

     ```

     scrollView.ep.reload()

     ```

     - Important:

     - 不走 tableView.reloadData() | collectionView.reloadData()

     */
    func reload() {
        base.emptyPageViewManager?.reload()
    }

}

public extension EmptyPage where Base: UIScrollView {

    /**
     空白页显示时, scroll能否滚动

     - Authors: linhey
     - Date: 2020/04/22

     - Example:

     ```

      scrollView.ep.isScrollEnabled = true  // 当空白页显示时可以滚动
      scrollView.ep.isScrollEnabled = false // 当空白页显示时不可以滚动

     ```
     */
    var canScrollEnabled: Bool {
        set {
            (base.emptyPageViewManager as? EmptyPageScrollViewManager)?.canScrollEnabled = newValue
        }
        get {
            return (base.emptyPageViewManager as? EmptyPageScrollViewManager)?.canScrollEnabled ?? false
        }
    }

}

public extension EmptyPage where Base: UITableView {

    /**
     设置 空白页视图

     - Authors: linhey
     - Date: 2020/04/22

     - Parameter view: 空白页视图
     - Parameter isReload: 是否需要刷新空白页显示

     - Example:

     ```

     scrollView.ep.setEmpty(EmptyView()))

     ```
     */
    func setEmpty(_ view: UIView?, isReload: Bool = false) {
        if base.emptyPageViewManager == nil {
            base.emptyPageViewManager = EmptyPageTableViewManager(delegate: base)
        }
        base.emptyPageViewManager?.setEmptyView(view)
        isReload ? reload() : ()
    }

}

public extension EmptyPage where Base: UICollectionView {

    /**
     设置 空白页视图

     - Authors: linhey
     - Date: 2020/04/22

     - Parameter view: 空白页视图
     - Parameter isReload: 是否需要刷新空白页显示

     - Example:

     ```

     scrollView.ep.setEmpty(EmptyView()))

     ```
     */
    func setEmpty(_ view: UIView?, isReload: Bool = false) {
        EmptyPageRuntime.swizzingLayout
        EmptyPageRuntime.swizzingCollectionView
        if base.emptyPageViewManager == nil {
            base.emptyPageViewManager = EmptyPageCollectionViewManager(delegate: base)
        }
        base.emptyPageViewManager?.setEmptyView(view)
        isReload ? reload() : ()
    }

}
