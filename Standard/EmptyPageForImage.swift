//
//  EmptyPageForImage.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public class EmptyPageForImage: UIView,EmptyPageViewProtocol {
  
  @IBOutlet public weak var imageView: UIImageView!

  /// 图片宽高比, default: 1
  public var imageAspect: CGFloat {
    set{ imageAspectConstraint = imageAspectConstraint.change(multiplier: newValue) }
    get{ return imageAspectConstraint.multiplier }
  }

  /// imageView: width -> imageView: height = 1
  @IBOutlet private weak var imageAspectConstraint: NSLayoutConstraint!

  public func config(images: [UIImage],duration: TimeInterval = 0, repeatCount: Int = 0) {
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
