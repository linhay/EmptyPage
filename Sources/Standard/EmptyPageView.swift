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
public protocol EmptyPageTemplateProtocol: UIView { }

public extension EmptyPageTemplateProtocol {
    
    /// 将不同空白页内容样式约束至背景View上
    ///
    /// - Returns: EmptyPageView
    func mix(layout: ((_ backView: UIView, _ view: UIView) -> Void)? = nil) -> EmptyPageView {
        return EmptyPageView(contentView: self, layout: layout)
    }
    
}

/// 自定义视图的容器视图
public class EmptyPageView: UIView {
    
    /// 内容视图
    public private(set) weak var contentView: UIView?

    // MARK: - Layout
    let topGuide    = UILayoutGuide()
    let leftGuide   = UILayoutGuide()
    let rightGuide  = UILayoutGuide()
    let bottomGuide = UILayoutGuide()

    private var contentViewLayout = ContentViewLayout()
    private var verticalLayout    = VerticalLayout()
    private var horizontalLayout  = HorizontalLayout()

    /// Vertical constraints
    /// 垂直方向上的约束
    class VerticalLayout {
        /// Constraints on the top and bottom guide height ratio
        /// 上下区域高度占比
        var topAndBottomHeightRatio: NSLayoutConstraint?
        /// Constraints on the top guide height
        /// 上区域高度
        var topGuideHeight: NSLayoutConstraint?
        /// Constraints on the bottom guide height
        /// 下区域高度
        var bottomGuideHeight: NSLayoutConstraint?
    }

    /// Vertical constraint types
    /// 垂直方向上的约束类型
    public enum VerticalLayoutType {
        /// top and bottom guide height ratio
        /// 上下区域高度占比
        case topAndBottomSpacerRatio(CGFloat)
        /// top guide height
        /// 上区域高度
        case topSpacer(CGFloat)
        /// bottom guide height
        /// 下区域高度
        case bottomSpacer(CGFloat)
    }

    /// Horizontal constraints
    /// 水平方向上的约束
    class HorizontalLayout {
        /// Constraints on the left and right guide width ratio
        /// 左右区域宽度占比
        var leftAndRightSpacerRatio: NSLayoutConstraint?
        /// Constraints on the left guide height
        /// 左侧区域宽度
        var leftSpacer: NSLayoutConstraint?
        /// Constraints on the right guide height
        /// 右侧区域高度
        var rightSpacer: NSLayoutConstraint?
    }

    /// Horizontal constraint types
    /// 水平方向上的约束类型
    public enum HorizontalLayoutType {
        /// Constraints on the left and right guide width ratio
        /// 左右区域宽度占比
        case leftAndRightSpacerRatio(CGFloat)
        /// Constraints on the left guide height
        /// 左侧区域宽度
        case leftSpacer(CGFloat)
        /// Constraints on the right guide height
        /// 右侧区域高度
        case rightSpacer(CGFloat)
    }

    class ContentViewLayout {
        public var top: NSLayoutConstraint?
        public var bottom: NSLayoutConstraint?
        public var left: NSLayoutConstraint?
        public var right: NSLayoutConstraint?
    }

    public init(contentView: EmptyPageTemplateProtocol, layout: ((_ self: UIView, _ view: EmptyPageTemplateProtocol) -> Void)? = nil) {
        super.init(frame: .zero)
        addSubview(contentView)

        if let layout = layout {
            layout(self, contentView)
            return
        }

        addLayoutGuide(topGuide)
        addLayoutGuide(leftGuide)
        addLayoutGuide(rightGuide)
        addLayoutGuide(bottomGuide)

        topGuide.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        bottomGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        leftGuide.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        rightGuide.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true

        /// Vertical constraints
        do {
            let constraint = topGuide.heightAnchor.constraint(equalTo: bottomGuide.heightAnchor, multiplier: 1)
            constraint.priority = .defaultLow
            constraint.isActive = true
            verticalLayout.topAndBottomHeightRatio = constraint
        }

        /// Horizontal constraints
        do {
            let constraint = leftGuide.widthAnchor.constraint(equalTo: rightGuide.widthAnchor, multiplier: 1)
            constraint.priority = .defaultLow
            constraint.isActive = true
            horizontalLayout.leftAndRightSpacerRatio = constraint
        }

        /// other
        do {
            let constraint = contentView.leftAnchor.constraint(equalTo: leftGuide.rightAnchor, constant: 0)
            constraint.isActive = true
            contentViewLayout.left = constraint
        }

        do {
            let constraint = contentView.topAnchor.constraint(equalTo: topGuide.bottomAnchor, constant: 0)
            constraint.isActive = true
            contentViewLayout.top = constraint
        }

        do {
            let constraint = contentView.rightAnchor.constraint(equalTo: rightGuide.leftAnchor, constant: 0)
            constraint.isActive = true
            contentViewLayout.right = constraint
        }

        do {
            let constraint = contentView.bottomAnchor.constraint(equalTo: bottomGuide.topAnchor, constant: 0)
            constraint.isActive = true
            contentViewLayout.bottom = constraint
        }

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

public extension EmptyPageView {

    /// Set the vertical constraint information.
    /// 设置垂直约束信息
    ///
    /// - Parameter types:
    ///   Vertical constraint types
    ///   垂直约束信息类型
    ///
    /// - Returns: Self
    @discardableResult
    func layout(vertical types: VerticalLayoutType...) -> Self {
        return layout(vertical: types)
    }

    /// Set the vertical constraint information.
    /// 设置垂直约束信息
    ///
    /// - Parameter types:
    ///   Vertical constraint types
    ///   垂直约束信息类型
    ///
    /// - Returns: Self
    @discardableResult
    func layout(vertical types: [VerticalLayoutType]) -> Self {
        types.forEach({ layout(vertical: $0) })
        return self
    }

    /// Set the vertical constraint information.
    /// 设置垂直约束信息
    ///
    /// - Parameter type:
    ///   Vertical constraint types
    ///   垂直约束信息类型
    ///
    /// - Returns: Self
    @discardableResult
    func layout(vertical type: VerticalLayoutType) -> Self {

        verticalLayout.topAndBottomHeightRatio?.isActive = false
        switch type {
        case .topAndBottomSpacerRatio(let value):
            verticalLayout.topGuideHeight?.isActive = false
            verticalLayout.bottomGuideHeight?.isActive = false
            let constraint = topGuide.heightAnchor.constraint(equalTo: bottomGuide.heightAnchor, multiplier: value)
            constraint.isActive = true
            verticalLayout.topAndBottomHeightRatio = constraint
        case .topSpacer(let value):
            verticalLayout.topGuideHeight?.isActive = false
            let constraint = topGuide.heightAnchor.constraint(equalToConstant: value)
            constraint.isActive = true
            verticalLayout.topGuideHeight = constraint
        case .bottomSpacer(let value):
            verticalLayout.bottomGuideHeight?.isActive = false
            let constraint = bottomGuide.heightAnchor.constraint(equalToConstant: value)
            constraint.isActive = true
            verticalLayout.bottomGuideHeight = constraint
        }

        return self
    }

    /// Set the horizontal constraint information.
    /// 设置水平方向约束信息
    ///
    /// - Parameter type:
    ///   Vertical constraint types
    ///   水平方向信息类型
    ///
    /// - Returns: Self
    @discardableResult
    func layout(horizontal types: HorizontalLayoutType...) -> Self {
        layout(horizontal: types)
    }

    /// Set the horizontal constraint information.
    /// 设置水平方向约束信息
    ///
    /// - Parameter type:
    ///   Vertical constraint types
    ///   水平方向信息类型
    ///
    /// - Returns: Self
    @discardableResult
    func layout(horizontal types: [HorizontalLayoutType]) -> Self {
        types.forEach({ layout(horizontal: $0) })
        return self
    }

    /// Set the horizontal constraint information.
    /// 设置水平方向约束信息
    ///
    /// - Parameter type:
    ///   Vertical constraint types
    ///   水平方向信息类型
    ///
    /// - Returns: Self
    @discardableResult
    func layout(horizontal type: HorizontalLayoutType) -> Self {

        horizontalLayout.leftAndRightSpacerRatio?.isActive = false
        switch type {
        case .leftAndRightSpacerRatio(let value):
            horizontalLayout.leftSpacer?.isActive = false
            horizontalLayout.rightSpacer?.isActive = false
            let constraint = leftGuide.widthAnchor.constraint(equalTo: rightGuide.widthAnchor, multiplier: value)
            constraint.isActive = true
            horizontalLayout.leftAndRightSpacerRatio = constraint

        case .leftSpacer(let value):
            horizontalLayout.leftSpacer?.isActive = false
            let constraint = leftGuide.widthAnchor.constraint(equalToConstant: value)
            constraint.isActive = true
            horizontalLayout.leftSpacer = constraint

        case .rightSpacer(let value):
            horizontalLayout.rightSpacer?.isActive = false
            let constraint = rightGuide.widthAnchor.constraint(equalToConstant: value)
            constraint.isActive = true
            horizontalLayout.rightSpacer = constraint
        }

        return self
    }

}

// MARK: - for configs method
public extension EmptyPageView {
    
    /// 配置 `EmptyPageView`
    ///
    /// - Parameter call: 视图回调
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    func config(view call: (_: EmptyPageView) -> Void) -> Self {
        call(self)
        return self
    }
    
}

// MARK: - for set method
public extension EmptyPageView {
    
    /// 配置 `EmptyPageView`
    ///
    /// - Parameter color: 背景颜色
    /// - Returns: 为支持链式调用,返回 `EmptyPageView`
    func set(backgroundColor color: UIColor) -> Self {
        backgroundColor = color
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
