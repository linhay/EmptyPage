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

/// `EmptyPageForText` 文字样式模板
open class EmptyPageForText: UILabel, EmptyPageTemplateProtocol {
    
    public var edge: UIEdgeInsets = .zero

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    func initialize() {
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(UILayoutPriority(UILayoutPriority.defaultHigh.rawValue - 1), for: .horizontal)
        setContentHuggingPriority(UILayoutPriority(UILayoutPriority.defaultHigh.rawValue - 1), for: .vertical)
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textColor = UIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1)
        textAlignment = .center
    }
}

// MARK: 深度配置元素 相关函数
public extension EmptyPageForText {

    /// 配置 `EmptyPageForText.label`
    ///
    /// - Parameter call: 元素回调, 回调 `EmptyPageForText.label`
    /// - Returns: 为支持链式调用,返回 `EmptyPageForText`
    @discardableResult
    func config(label call: (UILabel) -> Void) -> Self {
        call(self)
        return self
    }

}

// MARK: 轻度配置元素 相关函数
public extension EmptyPageForText {

    /// 设置 `EmptyPageForText.label`
    ///
    /// - Parameters:
    ///   - title: 文本
    ///   - color: 文本颜色 default: UIColor.black
    ///   - font:  字体 default: UIFont.systemFont(ofSize: 18)
    /// - Returns: 为支持链式调用,返回 `EmptyPageForText`
    @discardableResult
    func set(text: String, color: UIColor? = nil, font: UIFont? = nil) -> Self {
        self.text = text
        if let value = color {
            self.textColor = value
        }
        if let font = font {
            self.font = font
        }
        return self
    }

    /// 设置 `EmptyPageForText.label`
    ///
    /// - Parameter attributed: 富文本
    /// - Returns: 为支持链式调用,返回 `EmptyPageForText`
    @discardableResult
    func set(attributed: NSAttributedString) -> Self {
        self.attributedText = attributed
        return self
    }

}
