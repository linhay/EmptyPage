//
//  EmptyPageForCustom.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/1/12.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class EmptyPageForCustom: UIView {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var btn1: UIButton!
  @IBOutlet weak var btn2: UIButton!

  var block1: (()->())?
  var block2: (()->())?


  @IBAction func btn1TapEvent(_ sender: UIButton) {
    block1?()
  }

  @IBAction func btn2TapEvent(_ sender: UIButton) {
    block2?()
  }
  

  class var initFromNib: EmptyPageForCustom {
    return Bundle.main.loadNibNamed(String(describing: self),
                                    owner: nil,
                                    options: nil)?.first! as! EmptyPageForCustom
  }
  
}
