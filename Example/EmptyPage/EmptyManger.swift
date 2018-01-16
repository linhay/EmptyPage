//
//  EmptyManger.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
struct EmptyStates {
  
  static var loading: EmptyPageView{
    let view = EmptyPageForAnimation.initFromNib
    view.imageView.image = UIImage(named: "load-0")
    return .mix(view: view)
  }
  
  static func custom(block1: @escaping (()->()),
                     block2: @escaping (()->())) -> EmptyPageView {
    let view = EmptyPageForCustom.initFromNib
    
    view.imageView.image = UIImage(named: "empty")
    view.label.text = "点击下方按钮重试"
    view.btn1.setTitle("刷新", for: .normal)
    view.block1 = block1
    view.btn2.setTitle("获取数据", for: .normal)
    view.block2 = block2
    
    return .mix(view: view)
  }
  
}


/// 线程延时
public func sleep(_ time: Double,mainCall:@escaping ()->()) {
  let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
  DispatchQueue.main.asyncAfter(deadline: time) {
    mainCall()
  }
}

