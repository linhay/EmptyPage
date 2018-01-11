//
//  EmptyView.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

protocol EmptyPageViewProtocol: class {

}

extension EmptyPageViewProtocol {
  static var initFromNib: Self {
    return Bundle.main.loadNibNamed(String(describing: self),
                                    owner: nil,
                                    options: nil)?.first! as! Self
  }
}

class EmptyView: UIView,EmptyPageViewProtocol {

  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var textLabel: UILabel!
  @IBOutlet private weak var btn1: UIButton!
  @IBOutlet private weak var btn2: UIButton!

  private var btnBlock1: (()->())?
  private var btnBlock2: (()->())?

  @IBAction func tapEvent1(_ sender: UIButton) {
    btnBlock1?()
  }

  @IBAction func tapEvent2(_ sender: UIButton) {
    btnBlock2?()
  }

  static func config(images: UIImage...,
    isRotation: Bool,
    text: String?,
    btnTitle1: String?,
    btnTitle2: String?,
    btnBlock1: (()->())?,
    btnBlock2: (()->())?) -> EmptyView {
    let view = initFromNib

    if images.count == 1{
      view.imageView.image = images[0]
      view.begin(animate: isRotation)
    } else if images.count > 1{
      view.imageView.animationImages = images
      view.imageView.animationRepeatCount = Int.max
      view.imageView.startAnimating()
    } else if images.isEmpty {
      view.imageView.isHidden = true
    }

    if let text = text {
      view.textLabel.text = text
    }else {
      view.textLabel.isHidden = true
    }

    if let btnTitle = btnTitle1 {
      view.btn1.setTitle(btnTitle, for: .normal)
    }else {
      view.btn1.isHidden = true
    }

    if let btnTitle = btnTitle2 {
      view.btn2.setTitle(btnTitle, for: .normal)
    }else {
      view.btn2.isHidden = true
    }

    if let btnBlock = btnBlock1 { view.btnBlock1 = btnBlock }
    if let btnBlock = btnBlock2 { view.btnBlock2 = btnBlock }

    return view
  }

  func begin(animate: Bool) {
    guard animate else { return }
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.toValue = CGFloat.pi * 2
    rotationAnimation.duration = 2
    rotationAnimation.isCumulative = true
    rotationAnimation.repeatCount = .infinity
    imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
  }

  deinit {
    print(#function)
  }

}
