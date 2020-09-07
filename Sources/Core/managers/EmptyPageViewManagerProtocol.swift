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

    var targetBox: EmptyPageWeakBox<UIView> { get set }
    var emptyBox: EmptyPageWeakBox<UIView> { get set }
    var emptyViewProvider: () -> UIView? { get set }
    var frameKvoToken: NSKeyValueObservation? { get set }
    func resize()
    func isEmpty() -> Bool
    func reload(completion: ((_ isEmpty: Bool) -> Void)?)

}

public extension EmptyPageViewManagerProtocol {

    var target: UIView? { targetBox.value }
    var emptyView: UIView? { emptyBox.value }

    /// 空白页是否显示
    var isShow: Bool { emptyView != nil && emptyView?.superview != nil }

    func resize() {
        ep_resize()
    }

}

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
        guard self.target != target else {
            return
        }

        self.targetBox = .init(target)

        guard let target = target else {
            self.frameKvoToken?.invalidate()
            self.frameKvoToken = nil
            return
        }

        self.frameKvoToken = target.observe(\.bounds, options: [.new]) { [weak self] (_, _) in
            self?.resize()
        }
    }

    func ep_set(emptyViewProvider provider: (() -> UIView?)?) {
        self.emptyViewProvider = provider ?? { nil }
    }

    func ep_set(emptyView view: UIView?) {
           ep_set(emptyViewProvider: { view })
    }
}
