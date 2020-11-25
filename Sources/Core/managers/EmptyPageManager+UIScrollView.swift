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

    enum ScrollEnabledState: Int {
        case none
        case false_true
        case false_false
        case true_true
        case true_false
    }
    
    var scrollEnabledState = ScrollEnabledState.none
    
    /// 处理 ScrollView 滚动逻辑
    /// - Parameters:
    ///   - isShowBeforeReload: reload 之前空白页时是否正在显示
    ///   - isEmptyAfterReload: reload 之后数据源是否为空
    public func canScroll(isShowBeforeReload isShow: Bool, isEmptyAfterReload isEmpty: Bool) {
        guard let scrollView = scrollView else {
            return
        }

        switch (isShow, isEmpty && emptyView != nil) {
        case (false, true):
            guard scrollEnabledState != .false_true else {
                return
            }
            scrollEnabledState = .false_true
            isScrollEnabled = scrollView.isScrollEnabled
            scrollView.isScrollEnabled = canScrollEnabled
        case (false, false):
            scrollEnabledState = .false_false
        case (true, true):
            scrollEnabledState = .true_true
            scrollView.isScrollEnabled = canScrollEnabled
        case (true, false):
            scrollEnabledState = .true_false
            scrollView.isScrollEnabled = isScrollEnabled
        }
    }

    /// 刷新空白页
    open override func reload(completion: ((Bool) -> Void)? = nil) {
        let isShow = self.isShow
        super.reload { [weak self] isEmpty in
            self?.canScroll(isShowBeforeReload: isShow, isEmptyAfterReload: isEmpty)
            completion?(isEmpty)
        }
    }

}
