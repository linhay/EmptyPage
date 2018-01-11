//
//  EmptyPageStyle3View.swift
//  BuyerEmptyPage
//
//  Created by bigl on 2018/1/11.
//

import UIKit

class EmptyPageStyle3View: UIView,EmptyPageViewProtocol {

  @IBOutlet weak var label: UILabel!{
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
