//
//  EmptyPageForText.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public class EmptyPageForText: UIView,EmptyPageViewProtocol {

  @IBOutlet public weak var label: UILabel!{
    didSet{
      label.numberOfLines = 0
      label.textAlignment = .center
      label.textColor = .black
    }
  }

  func config(text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) {
    label.text = text
    label.textColor = color
    label.font = font
  }

  func congfig(attributed: NSAttributedString) {
    label.attributedText = attributed
  }

  
}
