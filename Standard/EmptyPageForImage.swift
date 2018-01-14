//
//  EmptyPageForImage.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

open class EmptyPageForImage: UIView,EmptyPageViewProtocol {
  
  @IBOutlet open weak var imageView: UIImageView!

  /// 图片宽高比, default: 1
  open var imageAspect: CGFloat {
    set{ imageAspectConstraint = imageAspectConstraint.change(multiplier: newValue) }
    get{ return imageAspectConstraint.multiplier }
  }

  /// imageView: width -> imageView: height = 1
  @IBOutlet private weak var imageAspectConstraint: NSLayoutConstraint!

  /// 设置图片
  ///
  /// - Parameter image: 图片
  open func config(image: UIImage) {
    config(images: [image], duration: 0, repeatCount: 0)
  }

  /// 设置图片组
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 播放时长
  ///   - repeatCount: 循环次数
  open func config(images: [UIImage],duration: TimeInterval, repeatCount: Int) {
    if let firstImage = images.first,
      firstImage.size.width != 0,
      firstImage.size.height != 0 {
      imageAspect = firstImage.size.width / firstImage.size.height
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
  }
  
  
}
