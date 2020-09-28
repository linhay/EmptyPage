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

public extension EmptyPage where Base: UIView {

    /// 空白页管理器
    var manager: EmptyPageViewManager? {
        if base.useCustomManager {
            return base.emptyPageViewManager
        }

        if base.emptyPageViewManager == nil, let placeholder = EmptyPageConfiguration.shared.viewGloalManager {
            set(manager: placeholder)
        }

        return base.emptyPageViewManager
    }

    /// 设置当前 View 的空白页管理器
    /// - Parameter manager: 空白页管理器
    func set(manager: EmptyPageViewManager?) {
        base.useCustomManager = true
        base.emptyPageViewManager = manager
        manager?.set(target: base)
    }

    /// 刷新空白页
    func reload() {
        manager?.reload()
    }

    /// 设置当前 View 的空白页
    /// - Parameter view: 自定义空白页
    func set(emptyView view: UIView?) {
        manager?.set(emptyView: view)
    }

}

public extension EmptyPage where Base: UIView {

    var emptyView: UIView? { manager?.emptyView }

    var isShow: Bool { manager?.isShow ?? false }

}
