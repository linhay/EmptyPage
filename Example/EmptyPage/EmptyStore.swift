//
//  EmptyManger.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

struct DZNEmptyDataSet {

}

struct DemoSet {

    func standard(tapEvent: ((EmptyPageForStandard) -> Void)?) -> EmptyPageView {
       return EmptyPageView.Template.standard
        .change(hspace: .button, value: 30)
        .change(vspace: .textWithButton, value: 10)
        .change(vspace: .titleWithText, value: 10)
        .config(button: { (item) in
            item.layer.borderColor = UIColor("#2ca3fa").cgColor
            item.layer.borderWidth = 1
            item.layer.cornerRadius = 5
            item.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            item.backgroundColor = .white
            item.setTitleColor(UIColor("#2ca3fa"), for: .normal)
            item.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        })
        .set(image: UIImage(named: "empty-1001")!)
        .set(title: "Nobody is following",
             color: UIColor("#536571"),
             font: UIFont.boldSystemFont(ofSize: 18))
        .set(text: "Following people helps you keep what they're saying and recommending.",
             color: UIColor("#c3ccd1"))
        .set(buttonTitle: "Find interesting people to follow >>")
        .set(tap: tapEvent)
        .mix()
        .set(backgroundColor: UIColor.white)
    }

}

class EmptyStore {

 static let dzn = DZNEmptyDataSet()
 static let demo = DemoSet()

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
      }.mix()
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

