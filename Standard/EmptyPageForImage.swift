//
//  EmptyPageForImage.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

open class EmptyPageForImage: UIView,EmptyPageViewProtocol {
  
  open let imageView = UIImageView()
  
  /// 配置图片控件
  ///
  /// - Parameter call: 图片控件回调
  /// - Returns: 返回空白页
  func config(call: ((_ imageView: UIImageView)->())) -> EmptyPageForImage{
    call(imageView)
    return self
  }
  
  /// 设置图片
  ///
  /// - Parameter image: 图片
  open func config(image: UIImage) -> EmptyPageForImage {
    return config(images: [image], duration: 0, repeatCount: 0)
  }
  
  /// 设置图片组
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 播放时长
  ///   - repeatCount: 循环次数
  open func config(images: [UIImage],duration: TimeInterval, repeatCount: Int = 0) -> EmptyPageForImage {
    if let firstImage = images.first,
      firstImage.size.width != 0,
      firstImage.size.height != 0 {
      // 防止图片过宽超出屏幕
      setImageAspect(float: firstImage.size.width / firstImage.size.height)
      if images.count == 1 {
        imageView.image = firstImage
      }
      else{
        imageView.animationDuration = duration
        imageView.animationRepeatCount = repeatCount
        imageView.animationImages = images
        imageView.startAnimating()
      }
    }
    return self
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
  
  func buildUI() {
    addSubview(imageView)
    let item0 = NSLayoutConstraint(item: imageView,attribute: .centerX,relatedBy: .equal,toItem: self,attribute: .centerX,multiplier: 1,constant: 0)
    
    let item2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageView]-|",
                                               options: NSLayoutFormatOptions(rawValue: 0),
                                               metrics: nil,
                                               views: ["imageView": imageView])
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    addConstraints(item2 + [item0])
  }
  
  func setImageAspect(float: CGFloat) {
    let item = NSLayoutConstraint(item: imageView,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: imageView,
                                  attribute: .height,
                                  multiplier: float,
                                  constant: 0)
    if let constraint = constraints.first(where: { (element) -> Bool in
      return element.firstItem as? NSObject == imageView
        && element.secondItem as? NSObject == imageView
    }) {
      removeConstraint(constraint)
    }
    addConstraint(item)
    updateConstraints()
  }
  
  
}
