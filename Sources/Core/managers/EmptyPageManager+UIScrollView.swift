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

open class EmptyPageScrollViewManager: EmptyPageViewManager {

    /// 设置空白页前视图是否可以滚动
    private(set) var isScrollEnabled: Bool = true
    /// 设置空白页后视图是否可以滚动
    open var canScrollEnabled: Bool = false
    /// 可滚动的父视图
    public var scrollView: UIScrollView? { target as? UIScrollView }

    open override func resize() {
        super.resize()
        emptyView?.frame.origin.y = scrollView?.contentOffset.y ?? 0
    }

    open override func reload(completion: ((Bool) -> Void)? = nil) {
        let isShow = self.isShow
        super.reload { [weak self] isEmpty in
            guard let self = self, let scrollView = self.scrollView else {
                completion?(isEmpty)
                return
            }

            switch (isShow, isEmpty && self.emptyView != nil) {
            case (false, true):
                self.isScrollEnabled = scrollView.isScrollEnabled
                scrollView.isScrollEnabled = self.canScrollEnabled
            case (false, false), (true, true):
                break
            case (true, false):
                scrollView.isScrollEnabled = self.isScrollEnabled
            }

            completion?(isEmpty)
        }
    }

}
