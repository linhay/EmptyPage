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

public protocol EmptyPageViewManagerProtocol: class {

    /// 被设置空白页的 View weak 引用.
    var targetBox: EmptyPageWeakBox<UIView> { get set }
    /// 自定义空白页的 weak 引用.
    var emptyBox: EmptyPageWeakBox<UIView> { get set }
    /// 生成空白页的闭包
    var emptyViewProvider: () -> UIView? { get set }
    /// kvo 目标视图的 frame, 用来动态调整空白页的尺寸
    var frameKvoToken: NSKeyValueObservation? { get set }
    /// 重新设置空白页的frame
    func resize()
    /// 判断数据源是否为空
    func isEmpty() -> Bool
    /// 刷新空白页
    /// - Parameter completion: 完成刷新回调
    func reload(completion: ((_ isEmpty: Bool) -> Void)?)

}

public extension EmptyPageViewManagerProtocol {

    /// 被设置空白页的 View
    var target: UIView? { targetBox.value }
    /// 自定义空白页
    var emptyView: UIView? { emptyBox.value }

    /// 空白页是否显示
    var isShow: Bool { emptyView != nil && emptyView?.superview != nil }

    /// 重新设置空白页的frame
    func resize() {
        ep_resize()
    }

}

/// 默认逻辑代码
public extension EmptyPageViewManagerProtocol {

    func ep_resize() {
        guard let delegate = target, let view = emptyView, view.superview == delegate else {
            return
        }
        view.frame = CGRect(origin: .zero, size: delegate.frame.size)
    }

    func ep_reload(completion: ((_ isEmpty: Bool) -> Void)? = nil) {
        emptyView?.removeFromSuperview()
        guard let delegate = target, isEmpty(), let view = emptyViewProvider() else {
            completion?(false)
            return
        }

        delegate.addSubview(view)
        emptyBox = .init(view)
        resize()
        #if swift(>=4.2)
        delegate.sendSubviewToBack(view)
        #else
        delegate.sendSubview(toBack: view)
        #endif

        completion?(true)
    }

    func ep_set(target: UIView?) {
        guard let target = target, self.target !== target else {
            return
        }
        self.targetBox = .init(target)

        /// [兼容] kvo 在 ios 12 以下会出现 token 连续释放的
        if #available(iOS 12, *) {
            self.frameKvoToken?.invalidate()
            self.frameKvoToken = target.observe(\.bounds, options: [.new]) { [weak self] (_, _) in
                self?.resize()
            }
        } else {
            _ = EmptyPageRuntime.swizzingLayout
        }
    }

    func ep_set(emptyViewProvider provider: (() -> UIView?)?) {
        self.emptyViewProvider = provider ?? { nil }
    }

    func ep_set(emptyView view: UIView?) {
        ep_set(emptyViewProvider: { view })
    }
}
