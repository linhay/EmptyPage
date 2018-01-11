//
//  EmptyPageView.swift
//  B7iOSBuyer
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit



class EmptyPageStyle1View: UIView,EmptyPageViewProtocol {
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var textLabel: UILabel!
  @IBOutlet private weak var button: UIButton!{
    didSet{
      button.layer.cornerRadius = 2
    }
  }
  
  private var event: (()->())?
  
  
  @IBAction func tapEvent(_ sender: UIButton) {
    event?()
  }
  
  func config(images: [UIImage],
              duration: TimeInterval = 0,
              repeatCount: Int = 0,
              title: NSAttributedString,
              text: NSAttributedString,
              btnTitle: String,
              btnTitleColor: UIColor = .white,
              btnTitleFont: UIFont = .systemFont(ofSize: 18),
              btnBackColor: UIColor = .blue,
              event: EmptyEvent) {
    configImageView(images: images,
                    duration: duration,
                    repeatCount: repeatCount)
    
    configTitle(attributed: title)
    
    configText(attributed: text)
    
    configBtn(title: btnTitle,
              titleColor: btnTitleColor,
              font: btnTitleFont,
              backColor: btnBackColor,
              event: event)
  }
  
  func config(images: [UIImage],
              duration: TimeInterval = 0,
              repeatCount: Int = 0,
              title: String,
              titleColor: UIColor = .black,
              titleFont: UIFont = .systemFont(ofSize: 18),
              text: String,
              textColor: UIColor = .lightGray,
              textFont: UIFont = .systemFont(ofSize: 18),
              btnTitle: String,
              btnTitleColor: UIColor = .white,
              btnTitleFont: UIFont = .systemFont(ofSize: 18),
              btnBackColor: UIColor = .blue,
              event: EmptyEvent) {
    
    configImageView(images: images,
                    duration: duration,
                    repeatCount: repeatCount)
    
    configTitle(text: title,
                color: titleColor,
                font: titleFont)
    
    configText(text: text,
               color: textColor,
               font: textFont)
    
    configBtn(title: btnTitle,
              titleColor: btnTitleColor,
              font: btnTitleFont,
              backColor: btnBackColor,
              event: event)
  }
  
}


extension EmptyPageStyle1View {
  private func configImageView(images: [UIImage],duration: TimeInterval, repeatCount: Int) {
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


  private func configTitle(text: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 18)) {
    titleLabel.text = text
    titleLabel.textColor = color
    titleLabel.font = font
  }

  private func configTitle(attributed: NSAttributedString) {
    titleLabel.attributedText = attributed
  }

  private func configText(text: String, color: UIColor = .lightGray, font: UIFont = .systemFont(ofSize: 18)) {
    textLabel.text = text
    textLabel.textColor = color
    textLabel.font = font
  }

  private func configText(attributed: NSAttributedString) {
    titleLabel.attributedText = attributed
  }

  private func configBtn(title: String,
                         titleColor: UIColor = .white,
                         font: UIFont = .systemFont(ofSize: 18),
                         backColor: UIColor = .blue,
                         event: EmptyEvent) {
    button.isHidden = title.isEmpty || event == nil
    button.setTitle(title, for: .normal)
    button.setTitleColor(titleColor, for: .normal)
    button.titleLabel?.font = font
    button.backgroundColor = backColor
    self.event = event
  }

}
