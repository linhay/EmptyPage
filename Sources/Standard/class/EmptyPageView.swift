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

/// `EmptyPageTemplateProtocol` 用于约束 `EmptyPageView` 中的内容视图(contentView), 并提供 `EmptyPageTemplateProtocol.mix()` 函数
public protocol EmptyPageTemplateProtocol: UIView {
    
    var edge: UIEdgeInsets { get set }
    
}

public extension EmptyPageTemplateProtocol {
    
    /// 将不同空白页内容样式约束至背景View上
    ///
    /// - Returns: EmptyPageView
    func mix(layout: ((_ backView: UIView, _ view: UIView) -> Void)? = nil) -> EmptyPageView {
        return EmptyPageView(contentView: self, layout: layout)
    }
    
    func layout(edge: UIEdgeInsets) -> Self {
        self.edge = edge
        return self
    }
    
}

/// 自定义视图的容器视图
public class EmptyPageView: UIView {
    
    /// 预设默认背景色
    public static var backColor: UIColor? = UIColor.white
    /// 内容视图
    public private(set) weak var contentView: UIView?
    /// 事件
    public var backgroundTapEvent = EmptyPageDelegate<Void, Void>()

    public let topGuide    = UILayoutGuide()
    public let leftGuide   = UILayoutGuide()
    public let rightGuide  = UILayoutGuide()
    public let bottomGuide = UILayoutGuide()

    private var edge: UIEdgeInsets = .zero
    /// 点击手势
    private lazy var tapGesture: UITapGestureRecognizer = {
        let item = UITapGestureRecognizer(target: self, action: #selector(backgroundTapAction))
        self.addGestureRecognizer(item)
        return item
    }()

    public init(contentView: EmptyPageTemplateProtocol, layout: ((_ self: UIView, _ view: EmptyPageTemplateProtocol) -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.edge = contentView.edge
        backgroundColor = EmptyPageView.backColor
        addSubview(contentView)

        if let layout = layout {
            layout(self, contentView)
            return
        }

        addLayoutGuide(topGuide)
        addLayoutGuide(leftGuide)
        addLayoutGuide(rightGuide)
        addLayoutGuide(bottomGuide)

        topGuide.heightAnchor.constraint(equalTo: bottomGuide.heightAnchor, multiplier: 1).isActive = true
        leftGuide.widthAnchor.constraint(equalTo: rightGuide.widthAnchor, multiplier: 1).isActive = true

        topGuide.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        bottomGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        leftGuide.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        rightGuide.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true

        do {
            let constraint = contentView.leftAnchor.constraint(equalTo: leftGuide.rightAnchor, constant: edge.left)
            constraint.priority = .defaultHigh
            constraint.isActive = true
        }

        do {
            let constraint = contentView.topAnchor.constraint(equalTo: topGuide.bottomAnchor, constant: edge.top)
            constraint.priority = .defaultHigh
            constraint.isActive = true
        }

        do {
            let constraint = contentView.rightAnchor.constraint(equalTo: rightGuide.leftAnchor, constant: edge.right)
            constraint.priority = .defaultHigh
            constraint.isActive = true
        }

        do {
            let constraint = contentView.bottomAnchor.constraint(equalTo: bottomGuide.topAnchor, constant: edge.bottom)
            constraint.priority = .defaultHigh
            constraint.isActive = true
        }

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
        backgroundColor = color
        return self
    }
    
    /// 设置 `EmptyPageView` 背景点击事件
    ///
    /// - Parameter event: 点击事件
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    @discardableResult
    public func setBackgroundTap() -> Self {
        _ = tapGesture
        return self
    }
    
}

// MARK: - for Template
extension EmptyPageView {
    
    /// 自定义视图模板
    public struct Template {
        /// 文本样式模板 `EmptyPageForText`
        public static var text: EmptyPageForText { return EmptyPageForText(frame: .zero) }
        /// 图片样式模板 `EmptyPageForImage`
        public static var image: EmptyPageForImage { return EmptyPageForImage(frame: .zero)  }
        /// 混合样式模板 `EmptyPageForStandard`
        public static var standard: EmptyPageForStandard { return EmptyPageForStandard(frame: .zero) }
    }
    
}
// MARK: - private method
extension EmptyPageView {
    
    /// 点击手势事件
    @objc private func backgroundTapAction() {
        backgroundTapEvent.call()
    }
    
}
