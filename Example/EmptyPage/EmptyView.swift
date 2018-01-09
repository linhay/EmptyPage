//
//  EmptyView.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

protocol EmptyViewDelegate: NSObjectProtocol {
  func emptyView(view: EmptyView,tapEvent: UIButton)
}

class EmptyView: UIView {

  weak var delegate: EmptyViewDelegate?

  class var initFromNib: EmptyView {
    return Bundle.main.loadNibNamed(String(describing: self),
                                    owner: nil,
                                    options: nil)?.first! as! EmptyView
  }

  @IBAction func tapEvent(_ sender: UIButton) {
    delegate?.emptyView(view: self, tapEvent: sender)
  }

}
