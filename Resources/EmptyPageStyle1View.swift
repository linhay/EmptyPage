//
//  EmptyPageView.swift
//  B7iOSBuyer
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit



class EmptyPageStyle1View: UIView,EmptyPageViewProtocol {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var button: UIButton!{
    didSet{
      button.layer.cornerRadius = 2
    }
  }

  var event: (()->())?


  @IBAction func tapEvent(_ sender: UIButton) {
    event?()
  }

  
  func config(images: [UIImage],duration: TimeInterval = 0, repeatCount: Int = 0,
              title: String, text: String, btnTitle: String, event: EmptyEvent) {
    titleLabel.text = title
    textLabel.text = text
    button.isHidden = btnTitle.isEmpty || event == nil
    button.setTitle(btnTitle, for: .normal)
    self.event = event

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
