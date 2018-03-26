//
//  EmptyPageForText.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

open class EmptyPageForText: UIView {
  
  open let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()
  
  /// 配置文本控件
  ///
  /// - Parameter call: 文本控件
  /// - Returns: 空白页组件
  open func config(call: (_ label: UILabel) -> ()) -> Self {
    call(label)
    return self
  }
  
  /// 设置文本
  ///
  /// - Parameters:
  ///   - text: 文本
  ///   - color: 文本颜色
  ///   - font: 文本字体
  open func config(text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) {
    label.text = text
    label.textColor = color
    label.font = font
  }
  
  /// 设置富文本
  ///
  /// - Parameter attributed: 富文本
  open func congfig(attributed: NSAttributedString) {
    label.attributedText = attributed
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
  
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
