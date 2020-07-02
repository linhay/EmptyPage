//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

open class EmptyPageViewManager: NSObject {

    // 父视图
    open private(set) weak var target: UIView?
    open private(set) weak var emptyView: UIView?

    open private(set) var makeEmptyView: () -> UIView? = { nil }
    
    /// 设置新空白页 or 移除空白页
    /// - Parameter emptyView: 新空白页, nil为移除当前空白页
    /// - Parameter target: 目标视图
    open func set(emptyView: (() -> UIView?)?, in target: UIView) {
        self.target = target
        self.makeEmptyView = emptyView ?? { nil }
    }

    /// 判断是否显示空白页
    /// - Returns: 是否显示空白页
    open func isEmpty() -> Bool { return false }

    /// 重置空白页尺寸
    open func resize() {
        guard let delegate = target, let view = emptyView else {
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
    }

    /// 处理展示空白页逻辑
    open func reload() {
        emptyView?.removeFromSuperview()
        guard let delegate = target, isEmpty(), let view = makeEmptyView() else {
            return
        }

        delegate.addSubview(view)

        emptyView = view
        resize()
        #if swift(>=4.2)
        delegate.sendSubviewToBack(view)
        #else
        delegate.sendSubview(toBack: view)
        #endif
    }

}

public extension EmptyPageViewManager {

    /// 空白页是否显示
    var isShow: Bool { emptyView != nil && emptyView?.superview == nil }

}
