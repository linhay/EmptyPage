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

/// `EmptyPageForImage` 图片样式模板
open class EmptyPageForImage: UIImageView, EmptyPageTemplateProtocol {
    
    public var edge: UIEdgeInsets = .zero
    
    // MARK: - private property
    private var customSize: CGSize?
    private lazy var height = heightAnchor.constraint(equalToConstant: 0)
    private lazy var width = widthAnchor.constraint(equalToConstant: 0)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

// MARK: 调整 layout 相关枚举与函数
public extension EmptyPageForImage {
    
    /// 调整尺寸
    /// - Parameter size: 尺寸
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    func layout(size: CGSize) -> Self {
        return layout(size: size, isCustom: true)
    }

    @discardableResult
    private func layout(size: CGSize?, isCustom: Bool) -> Self {
        guard let size = customSize ?? size else {
            height.constant = 0
            width.constant = 0
            return self
        }

        if isCustom {
            customSize = size
        }

        height.constant = size.height
        width.constant = size.width
        return self
    }

}

// MARK: 深度配置元素 相关函数
public extension EmptyPageForImage {
    
    /// 配置 `EmptyPageForImage.imageView`
    ///
    /// - Parameter call: 元素回调, 回调 `EmptyPageForImage.imageView`
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    func config(imageView call: (Self) -> Void) -> Self {
        call(self)
        return self
    }
    
}

// MARK: 轻度配置元素 相关函数
public extension EmptyPageForImage {
    
    /// 设置 `EmptyPageForImage.imageView`
    ///
    /// - Parameter value: 图片
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    func set(image: UIImage?) -> Self {
        layout(size: image?.size, isCustom: false)
        self.image = image
        return self
    }

    @discardableResult
    func set(images: [UIImage], duration: TimeInterval) -> Self {
        guard let firstImage = images.first else {
            set(image: nil)
            return self
        }

        layout(size: firstImage.size, isCustom: false)
        animationImages = images
        animationDuration = duration
        animationRepeatCount = 0
        startAnimating()
        return self
    }
    
}
