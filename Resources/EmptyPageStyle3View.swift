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
    }
  }

  func config(style: EmptyPage3Style = .title, text: String) {
    switch style {
    case .title:
      label.textColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1)
    case .text:
      label.textColor = UIColor(red: 146 / 255, green: 146 / 255, blue: 146 / 255, alpha: 1)
    }
    label.text = text
  }
  
}
