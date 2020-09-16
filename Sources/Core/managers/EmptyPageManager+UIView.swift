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

open class EmptyPageViewManager: EmptyPageViewManagerProtocol {

    // 父视图
    public var targetBox: EmptyPageWeakBox<UIView> = .init()
    public var emptyBox: EmptyPageWeakBox<UIView> = .init()
    public var frameKvoToken: NSKeyValueObservation?
    open var emptyViewProvider: () -> UIView? = { nil }

    public init() {}

    public init(target: UIView?) {
        set(target: target)
    }

    /// 设置目标视图
    /// - Parameter target: 目标视图
    open func set(target: UIView?) {
        ep_set(target: target)
    }

    /// 设置新空白页 or 移除空白页
    /// - Parameter emptyView: 新空白页, nil为移除当前空白页
    open func set(emptyViewProvider provider: (() -> UIView?)?) {
        ep_set(emptyViewProvider: provider)
    }

    /// 设置目标 View 的空白页
    /// - Parameter view: 自定义空白页
    open func set(emptyView view: UIView?) {
        ep_set(emptyView: view)
    }

    /// 判断是否显示空白页
    /// - Returns: 是否显示空白页
    open func isEmpty() -> Bool { return false }

    /// 重置空白页尺寸
    open func resize() {
        ep_resize()
    }

    /// 处理展示空白页逻辑
    open func reload(completion: ((_ isEmpty: Bool) -> Void)? = nil) {
        ep_reload(completion: completion)
    }

}
