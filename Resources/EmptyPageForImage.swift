//
//  EmptyPageForImage.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public class EmptyPageForImage: UIView,EmptyPageViewProtocol {


  @IBOutlet public weak var imageView: UIImageView!

  func config(images: [UIImage],duration: TimeInterval = 0, repeatCount: Int = 0) {
    if images.isEmpty { return }
    if images.count == 1 {
      imageView.image = images[0]
      return
    }
    imageView.animationDuration = duration
    imageView.animationRepeatCount = repeatCount
    imageView.animationImages = images
    imageView.startAnimating()
  }


}
