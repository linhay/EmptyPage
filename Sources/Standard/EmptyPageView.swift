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

/// `EmptyPageContentViewProtocol` 用于约束 `EmptyPageView` 中的内容视图(contentView), 并提供 `EmptyPageContentViewProtocol.mix()` 函数
public protocol EmptyPageContentViewProtocol: NSObjectProtocol { }

public extension EmptyPageContentViewProtocol {
  
  /// 将不同空白页内容样式约束至背景View上
  ///
  /// - Returns: EmptyPageView
  public func mix() -> EmptyPageView {
    guard let view = self as? UIView else { return EmptyPageView() }
    return EmptyPageView.mix(view: view)
  }
  
}

/// 自定义视图的容器视图
open class EmptyPageView: UIView {
  
  // MARK: - Public property
  /// 预设默认背景色
  public static var backColor: UIColor = UIColor.white
  /// backgroundView
  open class var backgroundView: EmptyPageView {
    let view = EmptyPageView(frame: UIScreen.main.bounds)
    view.backgroundColor = EmptyPageView.backColor
    return view
  }
  
  /// 将 自定义视图 约束至 `EmptyPageView` 上
  ///
  /// - Parameter view: 空白页内容样式
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
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
  
  /// 配置 `EmptyPageView`
  ///
  /// - Parameter color: 背景颜色
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  public func set(backgroundColor color: UIColor) -> Self {
    self.backgroundColor = color
    return self
  }
  
  /// 配置 `EmptyPageView`
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  public func config(view call: (_: EmptyPageView) -> ()) -> Self {
    call(self)
    return self
  }
  
  
  /// 自定义视图模板
  public struct ContentView {
    /// 文本样式模板 `EmptyPageForText`
    public static var onlyText: EmptyPageForText { return EmptyPageForText() }
    /// 图片样式模板 `EmptyPageForImage`
    public static var onlyImage: EmptyPageForImage { return EmptyPageForImage() }
    /// 混合样式模板 `EmptyPageForStandard`
    public static var standard: EmptyPageForStandard { return EmptyPageForStandard() }
  }
  
}







