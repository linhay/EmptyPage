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

/// `EmptyPageForText` 文字样式模板
open class EmptyPageForText: UIView, EmptyPageContentViewProtocol {
  
  // MARK: - Public property
  public let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()
  
  // MARK: - Override
  public init() {
    super.init(frame: CGRect.zero)
    buildUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
  
}


// MARK: 调整 layout 相关枚举与函数
extension EmptyPageForText {
  
  
  /// 修改视图水平方向上的间距
  ///
  /// - text: 文本左右间距
  public enum HSpaceType {
    case text
  }
  
  
  /// 修改视图水平方向上的间距
  ///
  /// - Parameters:
  ///   - space: 指定视图间距
  ///   - value: 修改值
  @discardableResult
  public func change(hspace type: HSpaceType,value: CGFloat) -> Self {
    
    let fromItem: NSObject = label
    let toItem: NSObject = self
    let priority = UILayoutPriority(999)
    
    let findItems = constraints.filter { (constraint) -> Bool in
      guard constraint.priority == priority,
        constraint.firstItem === fromItem,
        constraint.secondItem === toItem
        else { return false }
      return true
    }
    
    if findItems.isEmpty {
      let rightItem = NSLayoutConstraint(item: fromItem, attribute: .left,
                                         relatedBy: .equal,
                                         toItem: toItem, attribute: .left,
                                         multiplier: 1, constant: value)
      let leftItem = NSLayoutConstraint(item: fromItem, attribute: .right,
                                        relatedBy: .equal,
                                        toItem: toItem, attribute: .right,
                                        multiplier: 1, constant: -value)
      rightItem.priority = priority
      leftItem.priority = priority
      addConstraints([rightItem, leftItem])
    }else{
      findItems.forEach { (item) in
        item.constant = item.firstAttribute == .left ? value : -value
      }
    }
    
    updateConstraintsIfNeeded()
    return self
  }
  
  
}

// MARK: 深度配置元素 相关函数
extension EmptyPageForText {
  

  /// 配置 `EmptyPageForText.label`
  ///
  /// - Parameter call: 元素回调, 回调 `EmptyPageForText.label`
  /// - Returns: 为支持链式调用,返回 `EmptyPageForText`
  @discardableResult
  public func config(label call: (_: UILabel) -> ()) -> Self {
    call(label)
    return self
  }
  
  
}

// MARK: 轻度配置元素 相关函数
extension EmptyPageForText {
  
  
  /// 设置 `EmptyPageForText.label`
  ///
  /// - Parameters:
  ///   - title: 文本
  ///   - color: 文本颜色 default: UIColor.black
  ///   - font:  字体 default: UIFont.systemFont(ofSize: 18)
  /// - Returns: 为支持链式调用,返回 `EmptyPageForText`
  @discardableResult
  public func set(text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) -> Self {
    label.text = text
    label.textColor = color
    label.font = font
    return self
  }
  
  
  /// 设置 `EmptyPageForText.label`
  ///
  /// - Parameter attributed: 富文本
  /// - Returns: 为支持链式调用,返回 `EmptyPageForText`
  @discardableResult
  public func set(attributed: NSAttributedString) -> Self {
    label.attributedText = attributed
    return self
  }
  
  
}

extension EmptyPageForText {
  
  func buildUI() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    let layout0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|",
                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                 metrics: nil,
                                                 views: ["label" : label])
    _ = change(hspace: .text, value: 15)
    addConstraints(layout0)
  }
  
}
