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

open class EmptyPageForText: UIView, EmptyPageContentViewProtocol {
  
  public let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()
  
  public init() {
    super.init(frame: CGRect.zero)
    buildUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
  
}

// MARK: - config for views
extension EmptyPageForText {
  
  /// 配置图片控件
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 链式调用
 public func config(label call: (_: UILabel) -> ()) -> Self {
    call(label)
    return self
  }
  
}

// MARK: - set base info
extension EmptyPageForText {
  
  /// 设置文本
  ///
  /// - Parameters:
  ///   - text: 文本
  ///   - color: 文本颜色
  ///   - font: 文本字体
  public func set(text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) -> Self {
    label.text = text
    label.textColor = color
    label.font = font
    return self
  }
  
  /// 设置富文本
  ///
  /// - Parameter attributed: 富文本
  public func set(attributed: NSAttributedString) -> Self {
    label.attributedText = attributed
    return self
  }
  
}

extension EmptyPageForText {
  
  func buildUI() {
    addSubview(label)
    let layout0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|",
                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                 metrics: nil,
                                                 views: ["label" : label])
    let layout1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|",
                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                 metrics: nil,
                                                 views: ["label" : label])
    label.translatesAutoresizingMaskIntoConstraints = false
    addConstraints(layout0 + layout1)
  }
  
}
