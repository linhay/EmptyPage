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

/// `EmptyPageForImage` 图片样式模板
open class EmptyPageForImage: UIView, EmptyPageTemplateProtocol {

    public var edge: UIEdgeInsets = .zero

    // MARK: - Public property
    @IBOutlet public private(set) var imageView: UIImageView!
    
    // MARK: - private property
    private var customSize: CGSize?
    
    // MARK: - private NSLayoutConstraint
    @IBOutlet private var heightConstraint: NSLayoutConstraint!
    @IBOutlet private var widthConstraint: NSLayoutConstraint!
}

// MARK: 调整 layout 相关枚举与函数
extension EmptyPageForImage {
    
    /// 调整尺寸
    /// - Parameter size: 尺寸
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    public func change(size: CGSize) -> Self {
        customSize = size
        return layout(size: size)
    }
    
    @discardableResult
    private func layout(size: CGSize) -> Self {
        if let size = customSize {
            heightConstraint.constant = size.height
            widthConstraint.constant = size.width
            return self
        } else {
            heightConstraint.constant = size.height
            widthConstraint.constant = size.width
            return self
        }
    }
    
}

// MARK: 深度配置元素 相关函数
extension EmptyPageForImage {
    
    /// 配置 `EmptyPageForImage.imageView`
    ///
    /// - Parameter call: 元素回调, 回调 `EmptyPageForImage.imageView`
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    public func config(imageView call: (_: UIImageView) -> Void) -> Self {
        call(imageView)
        return self
    }
    
}

// MARK: 轻度配置元素 相关函数
extension EmptyPageForImage {
    
    /// 设置 `EmptyPageForImage.imageView`
    ///
    /// - Parameter value: 图片
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    public func set(image: UIImage?) -> Self {
        layout(size: image?.size ?? .zero)
        imageView.image = image
        return self
    }
    
    /// 设置 `EmptyPageForImage.imageView`
    ///
    /// - Parameters:
    ///   - images: 图片组
    ///   - duration: 播放时长
    ///   - repeatCount: 循环次数
    /// - Returns: 为支持链式调用,返回 `EmptyPageForImage`
    @discardableResult
    public func set(images: [UIImage], duration: TimeInterval, repeatCount: Int = 0) -> Self {
        layout(size: images.first?.size ?? .zero)
        imageView.animationDuration = duration
        imageView.animationRepeatCount = repeatCount
        imageView.animationImages = images
        imageView.startAnimating()
        return self
    }
    
}
