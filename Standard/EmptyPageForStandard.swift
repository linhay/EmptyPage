//
//  EmptyPageForStandard.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

open class EmptyPageForStandard: UIView,EmptyPageViewProtocol {
  
  /// imageView
  @IBOutlet open weak var imageView: UIImageView!
  /// 标题 Label
  @IBOutlet open weak var titleLabel: UILabel!
  /// 描述 Label
  @IBOutlet open weak var textLabel: UILabel!
  /// 底部 button
  @IBOutlet open weak var button: UIButton!{
    didSet{
      button.layer.cornerRadius = 2
      button.addTarget(self, action: #selector(tapEvent(_:)), for: .touchUpInside)
    }
  }
  
  /// 响应事件
  open var event: (()->())?
  
  /// 图片距离顶部约束距离, default: 20
  open var imageTopSpace: CGFloat {
    set{ imageTopSpaceConstraint.constant = newValue }
    get{ return imageTopSpaceConstraint.constant }
  }
  
  /// 图片与标题间距, default: 10
  open var imageWithTitleSpace: CGFloat {
    set{ imageWithTitleSpaceConstraint.constant = newValue }
    get{ return imageWithTitleSpaceConstraint.constant }
  }
  
  /// 标题与详情文本间距, default: 5
  open var titleWithTextSpace: CGFloat {
    set{ titleWithTextSpaceConstraint.constant = newValue }
    get{ return titleWithTextSpaceConstraint.constant }
  }
  
  /// 详情文本与按钮间距, default: 10
  open var textWithButtonSpace: CGFloat {
    set{ textWithButtonSpaceConstraint.constant = newValue }
    get{ return textWithButtonSpaceConstraint.constant }
  }
  
  /// 按钮距离底部间距, default: 20
  open var butttonWithBottomSpace: CGFloat {
    set{ butttonWithBottomSpaceConstraint.constant = newValue }
    get{ return butttonWithBottomSpaceConstraint.constant }
  }
  
  /// 图片宽高比, default: 1
  open var imageAspect: CGFloat {
    set{ imageAspectConstraint = imageAspectConstraint.change(multiplier: newValue) }
    get{ return imageAspectConstraint.multiplier }
  }
  
  /// 按钮最小宽度比例, default: 0.618
  open var buttonWidthMinAspect: CGFloat {
    set{ buttonWidthMinAspectConstraint = buttonWidthMinAspectConstraint.change(multiplier: newValue) }
    get{ return buttonWidthMinAspectConstraint.multiplier }
  }
  
  /// 标题左边距, default: 10
  open var titleLeftSpace: CGFloat {
    set{ titleLeftSpaceConstraint.constant = newValue }
    get{ return titleLeftSpaceConstraint.constant }
  }
  
  /// 标题右边距, default: 10
  open var titleRightSpace: CGFloat {
    set{ titleRightSpaceConstraint.constant = newValue }
    get{ return titleRightSpaceConstraint.constant }
  }
  
  /// 详情文本左边距, default: 10
  open var textLeftSpace: CGFloat {
    set{ textLeftSpaceConstraint.constant = newValue }
    get{ return textLeftSpaceConstraint.constant }
  }
  
  /// 详情文本右边距, default: 10
  open var textRightSpace: CGFloat {
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

  /// 默认样式
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 图片组时长
  ///   - repeatCount: 图片组循环次数
  ///   - title: 标题文本
  ///   - text: 描述文本
  ///   - btnTitle: 按钮文本
  ///   - btnTitleColor: 按钮文本颜色
  ///   - btnTitleFont: 按钮标题字体
  ///   - btnBackColor: 按钮本背景颜色
  ///   - event: 按钮点击事件
  /// - Returns: 空白页
  open func config(images: [UIImage],
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

  /// 默认样式
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 图片组循环播放时长
  ///   - repeatCount: 图片组循环播放次数
  ///   - title: 标题文本
  ///   - titleColor: 标题颜色, default: UIColor.black
  ///   - titleFont: 标题字体, default: 18
  ///   - text: 详情文本
  ///   - textColor: 详情文本颜色, default: UIColor.lightGray
  ///   - textFont: 详情字体, default: 18
  ///   - btnTitle: 按钮标题文本
  ///   - btnTitleColor: 按钮标题文本颜色 default: UIColor.white
  ///   - btnTitleFont: 按钮标题文本字体 default: 18
  ///   - btnBackColor: 按钮背景颜色
  ///   - event: 按钮事件
  /// - Returns: 空白页
  open func config(images: [UIImage],
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
  
  /// 设置图片
  ///
  /// - Parameter image: 图片
  open func configImageView(image: UIImage) {
    configImageView(images: [image], duration: 0, repeatCount: 0)
  }
  
  /// 设置图片组
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 播放时长
  ///   - repeatCount: 循环次数
  open func configImageView(images: [UIImage],duration: TimeInterval = 0, repeatCount: Int = 0) {
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

  /// 设置标题
  ///
  /// - Parameters:
  ///   - text: 文本
  ///   - color: 文本颜色
  ///   - font: 字体大小
  open func configTitle(text: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 18)) {
    titleLabel.text = text
    titleLabel.textColor = color
    titleLabel.font = font
  }
  
  /// 设置标题
  ///
  /// - Parameter attributed: 富文本
  open func configTitle(attributed: NSAttributedString) {
    titleLabel.attributedText = attributed
  }
  
  /// 设置描述文本
  ///
  /// - Parameters:
  ///   - text: 文本
  ///   - color: 文本颜色
  ///   - font: 字体大小
  open func configText(text: String, color: UIColor = .lightGray, font: UIFont = .systemFont(ofSize: 18)) {
    textLabel.text = text
    textLabel.textColor = color
    textLabel.font = font
  }
  
  /// 设置描述文本
  ///
  /// - Parameter attributed: 富文本
  open func configText(attributed: NSAttributedString) {
    textLabel.attributedText = attributed
  }
  
  /// 设置按钮
  ///
  /// - Parameters:
  ///   - title: 文本
  ///   - titleColor: 文本颜色
  ///   - font: 文本字体
  ///   - backColor: 按钮背景颜色
  ///   - event: 按钮事件
  open func configBtn(title: String,
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
