//
//  EmptyPage
//
//  Copyright (c) 2018 linhay - https://github.com/linhay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

import UIKit

public protocol EmptyPageContentViewProtocol: NSObjectProtocol { }

public extension EmptyPageContentViewProtocol {
  
  public func mix() -> EmptyPageView {
    guard let view = self as? UIView else { return EmptyPageView() }
    return EmptyPageView.mix(view: view)
  }
  
}

open class EmptyPageView: UIView {
  
  /// 预设默认背景色
  public static var backColor: UIColor = UIColor.white
  
  /// 获取一个空白页背景View
  open class var backgroundView: EmptyPageView {
    let view = EmptyPageView(frame: UIScreen.main.bounds)
    view.backgroundColor = EmptyPageView.backColor
    return view
  }
  
  /// 将不同空白页内容样式约束至背景View上
  ///
  /// - Parameter view: 空白页内容样式
  /// - Returns: 空白页
  open class func mix(view: UIView) -> EmptyPageView {
    let backView = backgroundView
    backView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    let lay1 = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: 0)
    let lay2 = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1, constant: 0)
    let lay3 = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view.superview, attribute: .width, multiplier: 1, constant: 0)
    backView.addConstraints([lay1,lay2,lay3])
    return backView
  }
  
 public func set(backgroundColor color: UIColor) -> EmptyPageView {
    self.backgroundColor = color
    return self
  }
  
  public struct ContentView {
    /// 纯文本样式
    public static var onlyText: EmptyPageForText { return EmptyPageForText() }
    /// 纯图片样式
    public static var onlyImage: EmptyPageForImage { return EmptyPageForImage() }
    /// 标准样式
    public static var standard: EmptyPageForStandard { return EmptyPageForStandard() }
  }
  
}







