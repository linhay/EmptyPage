//
//  EmptyPageView.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

class BuyerEmptyPage { }

protocol EmptyPageViewProtocol: class { }

public typealias EmptyEvent = (()->())?


extension EmptyPageViewProtocol {
  static public var initFromNib: Self {
    return Bundle(for: BuyerEmptyPage.self).loadNibNamed(String(describing: self),
                                                         owner: nil,
                                                         options: nil)?.first! as! Self
  }
}

public class EmptyPageView: UIView {
  
  /// 预设默认背景色
  public static var backColor: UIColor = UIColor(red: 244 / 255, green: 244 / 255, blue: 244 / 255, alpha: 1)
  
  /// 获取一个空白页背景View
  public class var backgroundView: EmptyPageView {
    let view = EmptyPageView(frame: UIScreen.main.bounds)
    view.backgroundColor = EmptyPageView.backColor
    return view
  }
  
  /// 将不同空白页内容样式约束至背景View上
  ///
  /// - Parameter view: 空白页内容样式
  /// - Returns: 空白页
  public class func mix(view: UIView) -> EmptyPageView {
    let backView = backgroundView
    backView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false

    let lay1 = NSLayoutConstraint(item: view,
                                  attribute: .centerX,
                                  relatedBy: .equal,
                                  toItem: view.superview,
                                  attribute: .centerX,
                                  multiplier: 1,
                                  constant: 0)
    
    let lay2 = NSLayoutConstraint(item: view,
                                  attribute: .centerY,
                                  relatedBy: .equal,
                                  toItem: view.superview,
                                  attribute: .centerY,
                                  multiplier: 1,
                                  constant: 0)
    
    let lay3 = NSLayoutConstraint(item: view,
                                  attribute: .width,
                                  relatedBy: .equal,
                                  toItem: view.superview,
                                  attribute: .width,
                                  multiplier: 1,
                                  constant: 0)
    
    backView.addConstraints([lay1,lay2,lay3])
    
    return backView
  }
  
}

public extension EmptyPageView {
  
  public struct StandardView {
    public static var onlyText: EmptyPageForText { return EmptyPageForText.initFromNib }
    public static var onlyImage: EmptyPageForImage { return EmptyPageForImage.initFromNib }
    public static var standard: EmptyPageForStandard {
      return EmptyPageForStandard.initFromNib
      
    }
  }
  
  
  /// 纯文字
  ///
  /// - Parameters:
  ///   - text: 文本
  ///   - color: 文本颜色, default: UIColor.black
  ///   - font: 文本字体大小, default: 18
  /// - Returns: 空白页
  public class func onlyText(text: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 18)) -> EmptyPageView {
    let view = EmptyPageForText.initFromNib
    view.config(text: text, color: color, font: font)
    return mix(view: view)
  }
  
  /// 纯文字(富文本)
  ///
  /// - Parameter attributed: 富文本
  /// - Returns: 空白页
  public class func onlyText(attributed: NSAttributedString) -> EmptyPageView {
    let view = EmptyPageForText.initFromNib
    view.congfig(attributed: attributed)
    return mix(view: view)
  }
  
  /// 纯图片(单张)
  ///
  /// - Parameter image: 图片
  /// - Returns: 空白页
  public class func onlyImage(image: UIImage) -> EmptyPageView {
    let view = EmptyPageForImage.initFromNib
    view.config(images: [image])
    return mix(view: view)
  }
  
  /// 纯图片样式
  ///
  /// - Parameters:
  ///   - images: 图片或图片组
  ///   - duration: 图片组循环播放时长
  ///   - repeatCount: 图片组循环播放次数
  /// - Returns: 空白页
  public class func onlyImages(images: [UIImage], duration: TimeInterval = 0, repeatCount: Int = 0) -> EmptyPageView {
    let view = EmptyPageForImage.initFromNib
    view.config(images: images, duration: duration, repeatCount: repeatCount)
    return mix(view: view)
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
  public class func standard(images: [UIImage],
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
                             event: EmptyEvent) -> EmptyPageView {
    let view = EmptyPageForStandard.initFromNib
    view.config(images: images,
                duration: duration,
                repeatCount: repeatCount,
                title: title,
                titleColor: titleColor,
                titleFont: titleFont,
                text: text,
                textColor: textColor,
                textFont: textFont,
                btnTitle: btnTitle,
                btnTitleColor: btnTitleColor,
                btnTitleFont: btnTitleFont,
                btnBackColor: btnBackColor,
                event: event)
    return mix(view: view)
  }
  
  public class func standard(images: [UIImage],
                             duration: TimeInterval = 0,
                             repeatCount: Int = 0,
                             title: NSAttributedString,
                             text: NSAttributedString,
                             btnTitle: String,
                             btnTitleColor: UIColor = .white,
                             btnTitleFont: UIFont = .systemFont(ofSize: 18),
                             btnBackColor: UIColor = .blue,
                             event: EmptyEvent) -> EmptyPageView {
    let view = EmptyPageForStandard.initFromNib
    view.config(images: images,
                duration: duration,
                repeatCount: repeatCount,
                title: title,
                text: text,
                btnTitle: btnTitle,
                btnTitleColor: btnTitleColor,
                btnTitleFont: btnTitleFont,
                btnBackColor: btnBackColor,
                event: event)
    return mix(view: view)
  }
}







