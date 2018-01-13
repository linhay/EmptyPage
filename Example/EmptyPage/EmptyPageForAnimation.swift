//
//  EmptyPageForAnimation.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class EmptyPageForAnimation: UIView {
  
  @IBOutlet weak var imageView: UIImageView!{
    didSet{
      let animation = CABasicAnimation(keyPath: "transform.rotation.z")
      animation.fromValue = CGFloat.pi * 2
      animation.toValue = 0
      animation.duration = 2
      animation.autoreverses = false
      animation.fillMode = kCAFillModeForwards
      animation.repeatCount = Float.infinity
      imageView.layer.add(animation, forKey: nil)
    }
  }
  
  
  class var initFromNib: EmptyPageForAnimation {
    return Bundle.main.loadNibNamed(String(describing: self),
                                    owner: nil,
                                    options: nil)?.first! as! EmptyPageForAnimation
  }
  
}
