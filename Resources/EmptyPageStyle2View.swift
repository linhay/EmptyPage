//
//  EmptyPageStyle2View.swift
//  BuyerEmptyPage
//
//  Created by bigl on 2018/1/10.
//

import UIKit

class EmptyPageStyle2View: UIView,EmptyPageViewProtocol {


  @IBOutlet weak var imageView: UIImageView!

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
