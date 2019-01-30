//
//  EmptyManger.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
class EmptyStore {
  
  class var loading: EmptyPageView{
    return EmptyPageView.Template.image
      .set(image: UIImage(named: "load-0"))
      .config { (item) in
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = CGFloat.pi * 2
        animation.toValue = 0
        animation.duration = 2
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.repeatCount = Float.infinity
        item.layer.add(animation, forKey: nil)
      }
      .mix()
  }
  
  class func custom(block1: @escaping (()->()),
                     block2: @escaping (()->())) -> EmptyPageView {
    let view = EmptyPageForCustom.initFromNib
    view.imageView.image = UIImage(named: "empty")
    view.label.text = "点击下方按钮重试"
    view.btn1.setTitle("刷新", for: .normal)
    view.block1 = block1
    view.btn2.setTitle("获取数据", for: .normal)
    view.block2 = block2
    return view.mix()
  }
  
}


/// 线程延时
public func sleep(_ time: Double,mainCall:@escaping ()->()) {
  let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
  DispatchQueue.main.asyncAfter(deadline: time) {
    mainCall()
  }
}

