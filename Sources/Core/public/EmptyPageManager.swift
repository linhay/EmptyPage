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

open class EmptyPageViewManager: NSObject {

    // 空白页视图
    open private(set) var view: UIView?
    // 父视图
    open private(set) weak var delegate: UIView?
    open private(set) var isEmpty: () -> Bool

    public init(delegate: UIView, isEmpty: @escaping () -> Bool) {
        self.isEmpty = isEmpty
        super.init()
        self.delegate = delegate
    }

    open func setEmptyView(_ view: UIView?) {
        self.view?.removeFromSuperview()
        self.view = view
    }

    open func resize() {
        guard let delegate = delegate, let view = view else {
            return
        }
        view.frame = CGRect(origin: .zero, size: delegate.frame.size)
    }

    open func reload() {
        view?.removeFromSuperview()
        guard let delegate = delegate, let view = view, isEmpty() else {
            return
        }
        if #available(iOS 11.0, *) {
            let height = delegate.frame.size.height - (delegate.safeAreaInsets.top + delegate.safeAreaInsets.bottom)
            let width = delegate.frame.size.width - (delegate.safeAreaInsets.left + delegate.safeAreaInsets.right)
            view.frame = CGRect(origin: .zero,
                                size: .init(width: width, height: height))
        } else {
            view.frame = CGRect(origin: .zero, size: delegate.frame.size)
        }
        delegate.addSubview(view)
        #if swift(>=4.2)
        delegate.sendSubviewToBack(view)
        #else
        delegate.sendSubview(toBack: view)
        #endif
    }

}

open class EmptyPageScrollViewManager: EmptyPageViewManager {

    private(set) var isScrollEnabled: Bool = true
    open var canScrollEnabled: Bool = false
    private var scrollView: UIScrollView? { delegate as? UIScrollView }

    open override func reload() {
        guard let scrollView = scrollView else {
            super.reload()
            return
        }

        if view?.superview == nil {
            isScrollEnabled = scrollView.isScrollEnabled
        }

        if isEmpty() {
            scrollView.isScrollEnabled = canScrollEnabled
        } else {
            scrollView.isScrollEnabled = isScrollEnabled
        }

        super.reload()
    }

}

class EmptyPageTableViewManager: EmptyPageScrollViewManager {

    convenience init(delegate: UITableView) {
        self.init(delegate: delegate) { [weak delegate] () -> Bool in
            guard let tableView = delegate else {
                return false
            }

            let count = tableView.dataSource?.numberOfSections?(in: tableView) ?? tableView.numberOfSections
            return (0..<count).contains(where: { tableView.numberOfRows(inSection: $0) > 0 }) == false
        }
    }

}

class EmptyPageCollectionViewManager: EmptyPageScrollViewManager {

    convenience init(delegate: UICollectionView) {
        self.init(delegate: delegate) { [weak delegate] () -> Bool in
            guard let collectionView = delegate else {
                return false
            }

            let count = collectionView.dataSource?.numberOfSections?(in: collectionView) ?? collectionView.numberOfSections
            return (0..<count).contains(where: { collectionView.numberOfItems(inSection: $0) > 0 }) == false
        }
    }

}
