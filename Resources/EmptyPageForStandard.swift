//
//  EmptyPageForStandard.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public class EmptyPageForStandard: UIView,EmptyPageViewProtocol {
  
  /// imageView
  @IBOutlet public weak var imageView: UIImageView!
  /// 标题 Label
  @IBOutlet public weak var titleLabel: UILabel!
  /// 描述 Label
  @IBOutlet public weak var textLabel: UILabel!
  /// 底部 button
  @IBOutlet public weak var button: UIButton!{
    didSet{
      button.layer.cornerRadius = 2
      button.addTarget(self, action: #selector(tapEvent(_:)), for: .touchUpInside)
    }
  }
  
  /// 响应事件
  public var event: (()->())?
  
  /// 图片距离顶部约束距离, default: 20
  public var imageTopSpace: CGFloat {
    set{ imageTopSpaceConstraint.constant = newValue }
    get{ return imageTopSpaceConstraint.constant }
  }
  
  /// 图片与标题间距, default: 10
  public var imageWithTitleSpace: CGFloat {
    set{ imageWithTitleSpaceConstraint.constant = newValue }
    get{ return imageWithTitleSpaceConstraint.constant }
  }
  
  /// 标题与详情文本间距, default: 10
  public var titleWithTextSpace: CGFloat {
    set{ titleWithTextSpaceConstraint.constant = newValue }
    get{ return titleWithTextSpaceConstraint.constant }
  }
  
  /// 详情文本与按钮间距, default: 10
  public var textWithButtonSpace: CGFloat {
    set{ textWithButtonSpaceConstraint.constant = newValue }
    get{ return textWithButtonSpaceConstraint.constant }
  }
  
  /// 按钮距离底部间距, default: 20
  public var butttonWithBottomSpace: CGFloat {
    set{ butttonWithBottomSpaceConstraint.constant = newValue }
    get{ return butttonWithBottomSpaceConstraint.constant }
  }
  
  /// 图片宽高比, default: 1
  public var imageAspect: CGFloat {
    set{ imageAspectConstraint = imageAspectConstraint.change(multiplier: newValue) }
    get{ return imageAspectConstraint.multiplier }
  }
  
  /// 按钮最小宽度比例, default: 0.618
  public var buttonWidthMinAspect: CGFloat {
    set{ buttonWidthMinAspectConstraint = buttonWidthMinAspectConstraint.change(multiplier: newValue) }
    get{ return buttonWidthMinAspectConstraint.multiplier }
  }
  
  /// 标题左边距, default: 10
  public var titleLeftSpace: CGFloat {
    set{ titleLeftSpaceConstraint.constant = newValue }
    get{ return titleLeftSpaceConstraint.constant }
  }
  
  /// 标题右边距, default: 10
  public var titleRightSpace: CGFloat {
    set{ titleRightSpaceConstraint.constant = newValue }
    get{ return titleRightSpaceConstraint.constant }
  }
  
  /// 详情文本左边距, default: 10
  public var textLeftSpace: CGFloat {
    set{ textLeftSpaceConstraint.constant = newValue }
    get{ return textLeftSpaceConstraint.constant }
  }
  
  /// 详情文本右边距, default: 10
  public var textRightSpace: CGFloat {
    set{ textRightSpaceConstraint.constant = newValue }
    get{ return textRightSpaceConstraint.constant }
  }
  
  
  /// imageView: top -> superView: top = 20
  @IBOutlet private weak var imageTopSpaceConstraint: NSLayoutConstraint!
  /// imageView: bottom -> titleLabel: top = 10
  @IBOutlet private weak var imageWithTitleSpaceConstraint: NSLayoutConstraint!
  /// titleLabel: bottom -> textLabel: top = 10
  @IBOutlet private weak var titleWithTextSpaceConstraint: NSLayoutConstraint!
  /// textLabel: bottom -> button: top = 20
  @IBOutlet private weak var textWithButtonSpaceConstraint: NSLayoutConstraint!
  /// button: bottom -> superView: bottom = 20
  @IBOutlet private weak var butttonWithBottomSpaceConstraint: NSLayoutConstraint!
  /// imageView: width -> imageView: height = 1
  @IBOutlet private weak var imageAspectConstraint: NSLayoutConstraint!
  /// button: width -> superView: width >= 0.618
  @IBOutlet private weak var buttonWidthMinAspectConstraint: NSLayoutConstraint!
  /// titleLabel: left -> superView: left = 10
  @IBOutlet private weak var titleLeftSpaceConstraint: NSLayoutConstraint!
  /// titleLabel: right -> superView: right = -10
  @IBOutlet private weak var titleRightSpaceConstraint: NSLayoutConstraint!
  /// textLabel: left -> superView: left = 10
  @IBOutlet private weak var textLeftSpaceConstraint: NSLayoutConstraint!
  /// textLabel: right -> superView: right = -10
  @IBOutlet private weak var textRightSpaceConstraint: NSLayoutConstraint!
  
  
  @objc func tapEvent(_ sender: UIButton) {
    event?()
  }
  
}


// MARK: - 对接 EmptyPageView 中函数
public extension EmptyPageForStandard {
  
  public func config(images: [UIImage],
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
  
  public func config(images: [UIImage],
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


// MARK: - private 控件配置 函数
public extension EmptyPageForStandard {
  public func configImageView(images: [UIImage],duration: TimeInterval, repeatCount: Int) {
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
  
  
  public func configTitle(text: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 18)) {
    titleLabel.text = text
    titleLabel.textColor = color
    titleLabel.font = font
  }
  
  public func configTitle(attributed: NSAttributedString) {
    titleLabel.attributedText = attributed
  }
  
  public func configText(text: String, color: UIColor = .lightGray, font: UIFont = .systemFont(ofSize: 18)) {
    textLabel.text = text
    textLabel.textColor = color
    textLabel.font = font
  }
  
  public func configText(attributed: NSAttributedString) {
    textLabel.attributedText = attributed
  }
  
  public func configBtn(title: String,
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
