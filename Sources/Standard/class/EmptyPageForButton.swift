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

open class EmptyPageForButton: UIButton {
    
    public struct Style {
        public var backgroundColor: UIColor? = .systemBlue
        public var titleLabelFont: UIFont = .systemFont(ofSize: 16, weight: .medium)
        public var cornerRadius: CGFloat = 4
        public var clipsToBounds: Bool = true
        public var contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center
        public var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center
        public var contentEdgeInsets: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    public static let style = Style()
    private var tapEvent: (() -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    @discardableResult
    public func set(tapEvent: (() -> Void)?) -> Self {
        self.tapEvent = tapEvent
        removeTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
        if tapEvent != nil {
            addTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
        }
        return self
    }
    
    @discardableResult
    public func set(style: Style) -> Self {
        backgroundColor = style.backgroundColor
        titleLabel?.font =  style.titleLabelFont
        layer.cornerRadius = style.cornerRadius
        clipsToBounds = style.clipsToBounds
        contentVerticalAlignment = style.contentVerticalAlignment
        contentHorizontalAlignment = style.contentHorizontalAlignment
        contentEdgeInsets = style.contentEdgeInsets
        return self
    }
    
    private func initialize() {
        set(style: Self.style)
    }
    
    @objc
    private func touchUpInsideAction() {
        tapEvent?()
    }
    
}
