//
//  EmptyPageForText.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

open class EmptyPageForText: UIView,EmptyPageViewProtocol {

  @IBOutlet open weak var label: UILabel!{
    didSet{
      label.numberOfLines = 0
      label.textAlignment = .center
      label.textColor = .black
    }
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

  
}
