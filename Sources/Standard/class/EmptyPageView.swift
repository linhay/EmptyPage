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

/// `EmptyPageTemplateProtocol` 用于约束 `EmptyPageView` 中的内容视图(contentView), 并提供 `EmptyPageTemplateProtocol.mix()` 函数
public protocol EmptyPageTemplateProtocol: NSObjectProtocol { }

public extension EmptyPageTemplateProtocol {

    /// 将不同空白页内容样式约束至背景View上
    ///
    /// - Returns: EmptyPageView
    func mix() -> EmptyPageView {
        guard let view = self as? UIView else { return EmptyPageView() }
        return EmptyPageView.mix(view: view)
    }

    /// 将不同空白页内容样式约束至背景View上
    ///
    /// - Parameter config: 自定义约束
    /// - Returns: EmptyPageView
    func mix(_ config: ((_: UIView) -> Void)) -> EmptyPageView {
        guard let view = self as? UIView else { return EmptyPageView() }
        return EmptyPageView.mix(view: view)
    }

}

/// 自定义视图的容器视图
public class EmptyPageView: UIView {

    /// 内容视图
    public weak var contentView: UIView?

    /// 事件
    public var eventStore: ((_: EmptyPageView) -> Void)?

    /// 点击手势
    lazy var tapGesture: UITapGestureRecognizer = {
        let item = UITapGestureRecognizer(target: self, action: #selector(event))
        self.addGestureRecognizer(item)
        return item
    }()

}

// MARK: - for configs method
extension EmptyPageView {

    /// 配置 `EmptyPageView`
    ///
    /// - Parameter call: 视图回调
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    public func config(view call: (_: EmptyPageView) -> Void) -> Self {
        call(self)
        return self
    }

}

// MARK: - for set method
extension EmptyPageView {

    /// 配置 `EmptyPageView`
    ///
    /// - Parameter color: 背景颜色
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    public func set(backgroundColor color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    /// 设置 `EmptyPageView` 背景点击事件
    ///
    /// - Parameter event: 点击事件
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    @discardableResult
    public func set(tap event: ((_: EmptyPageView) -> Void)?) -> Self {
        _ = self.tapGesture
        eventStore = event
        return self
    }

}

// MARK: - for Template
extension EmptyPageView {

    /// 自定义视图模板
    public struct Template {

        static func load<T: UIView>() -> T {
            let bundle = Bundle(path: Bundle(for: EmptyPageView.self).path(forResource: "Standard", ofType: "bundle")!)
            let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
            let view = nib.instantiate(withOwner: nib, options: nil).first
            return view as! T
        }

        /// 文本样式模板 `EmptyPageForText`
        public static var text: EmptyPageForText { return EmptyPageForText() }
        /// 图片样式模板 `EmptyPageForImage`
        public static var image: EmptyPageForImage { return load() as EmptyPageForImage }
        /// 混合样式模板 `EmptyPageForStandard`
        public static var standard: EmptyPageForStandard { return EmptyPageForStandard() }
    }

}

// MARK: - class method
extension EmptyPageView {

    /// 预设默认背景色
    public static var backColor: UIColor = UIColor.white

    /// backgroundView
    public class var backgroundView: EmptyPageView {
        let view = EmptyPageView(frame: UIScreen.main.bounds)
        view.backgroundColor = EmptyPageView.backColor
        return view
    }

}

// MARK: - mix methods
public extension EmptyPageView {

    /// 将 自定义视图 约束至 `EmptyPageView` 上
    ///
    /// - Parameters:
    ///   - view: 空白页内容样式
    ///   - config: 自定义约束
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    class func mix(backView: EmptyPageView = backgroundView, view: UIView) -> EmptyPageView {
        backView.addSubview(view)
        backView.contentView = view
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: backView.widthAnchor).isActive = true
        return backView
    }
}

// MARK: - private method
extension EmptyPageView {

    /// 点击手势事件
    @objc private func event() {
        eventStore?(self)
    }

}
