//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

open class EmptyPageScrollViewManager: EmptyPageViewManager {

    /// 设置空白页前视图是否可以滚动
    private(set) var isScrollEnabled: Bool = true
    /// 设置空白页后视图是否可以滚动
    open var canScrollEnabled: Bool = false
    /// 可滚动的父视图
    public var scrollView: UIScrollView? { delegate as? UIScrollView }

    open override func reload() {
        guard let scrollView = scrollView else {
            super.reload()
            return
        }

        if isShow == false {
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
