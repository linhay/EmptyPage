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

public extension EmptyPage where Base: UIScrollView {

    /// 设置 空白页视图
    /// - Parameter view: 空白页视图
    func setEmpty(_ view: UIView?) {
        base.emptyView = view
    }

    /// 设置 第一次 reload 采用的空白页(可用于加载loading)
    /// - Parameter view: 空白页视图
    func setFirstLoading(_ view: UIView?) {
        base.firstLoadingView = view
    }

    /// 主动触发空白页视图显示逻辑
    func reload() {
        base.setEmptyView(base.isEmpty)
    }

    /// 空白页视图
    var emptyView: UIView? {
        set { base.emptyView = newValue }
        get { return base.emptyView }
    }

    /// 第一次 reload 采用的空白页(可用于加载loading)
    var firstLoadingView: UIView? {
        set { base.firstLoadingView = newValue }
        get { return base.firstLoadingView }
    }

}
