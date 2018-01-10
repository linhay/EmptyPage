//
//  EmptyPageType.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage


extension EmptyView {

  static func loading() -> EmptyView {
    return EmptyView.config(images:  UIImage(named: "load")!,
                            isRotation: true,
                            text: nil,
                            btnTitle1: nil,
                            btnTitle2: nil,
                            btnBlock1: nil,
                            btnBlock2: nil)
  }

  static func noData(block1: @escaping (() -> ()),
                     block2: @escaping (() -> ())) -> EmptyView {
    return EmptyView.config(images: UIImage(named: "empty")!,
                            isRotation: false,
                            text: "按刷新试试",
                            btnTitle1: "加载数据",
                            btnTitle2: "重新请求",
                            btnBlock1: block1,
                            btnBlock2: block2)
  }

}
