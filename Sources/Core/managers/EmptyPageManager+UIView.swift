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

open class EmptyPageViewManager: NSObject {

    // 父视图
    open private(set) weak var target: UIView?
    open private(set) weak var emptyView: UIView?
    open private(set) var emptyViewProvider: () -> UIView? = { nil }

    public override init() {
        super.init()
    }

    public init(target: UIView?) {
        super.init()
        self.target = target
    }

    /// 设置目标视图
    /// - Parameter target: 目标视图
    open func set(target: UIView?) {
        self.target = target
    }

    /// 设置新空白页 or 移除空白页
    /// - Parameter emptyView: 新空白页, nil为移除当前空白页
    open func set(emptyViewProvider provider: (() -> UIView?)?) {
        self.emptyViewProvider = provider ?? { nil }
    }

    open func set(emptyView view: UIView?) {
        set(emptyViewProvider: { view })
    }

    /// 判断是否显示空白页
    /// - Returns: 是否显示空白页
    open func isEmpty() -> Bool { return false }

    /// 重置空白页尺寸
    open func resize() {
        guard let delegate = target, let view = emptyView, view.superview == delegate else {
            return
        }
        view.frame = CGRect(origin: .zero, size: delegate.frame.size)
    }

    /// 处理展示空白页逻辑
    open func reload() {
        emptyView?.removeFromSuperview()
        guard let delegate = target, isEmpty(), let view = emptyViewProvider() else {
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
    var isShow: Bool { emptyView != nil && emptyView?.superview != nil }

}
