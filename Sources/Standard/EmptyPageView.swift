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
@available(iOS,introduced: 8.0, deprecated: 8.0, renamed: "EmptyPageTemplateProtocol")
public protocol EmptyPageContentViewProtocol: EmptyPageTemplateProtocol { }

/// `EmptyPageTemplateProtocol` 用于约束 `EmptyPageView` 中的内容视图(contentView), 并提供 `EmptyPageTemplateProtocol.mix()` 函数
public protocol EmptyPageTemplateProtocol: NSObjectProtocol { }

public extension EmptyPageTemplateProtocol {
  
  /// 将不同空白页内容样式约束至背景View上
  ///
  /// - Returns: EmptyPageView
  public func mix() -> EmptyPageView {
    guard let view = self as? UIView else { return EmptyPageView() }
    return EmptyPageView.mix(view: view)
  }
  
  /// 将不同空白页内容样式约束至背景View上
  ///
  /// - Parameter config: 自定义约束
  /// - Returns: EmptyPageView
  public func mix(_ config: ((_: UIView) -> Void)) -> EmptyPageView {
    guard let view = self as? UIView else { return EmptyPageView() }
    return EmptyPageView.mix(view: view, config)
  }
  
}

/// 自定义视图的容器视图
public class EmptyPageView: UIView {
  
  /// 内容视图
  public weak var contentView: UIView?
  
  /// 事件
  public var eventStore: ((_: EmptyPageView) -> Void)?
  
  /// 点击手势
  lazy var tapGesture: UITapGestureRecognizer = {
    let item = UITapGestureRecognizer(target: self, action: #selector(event))
    self.addGestureRecognizer(item)
    return item
  }()
  
}

// MARK: - for configs method
extension EmptyPageView{
  
  /// 配置 `EmptyPageView`
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  public func config(view call: (_: EmptyPageView) -> ()) -> Self {
    call(self)
    return self
  }
  
}

// MARK: - for set method
extension EmptyPageView {
  
  /// 配置 `EmptyPageView`
  ///
  /// - Parameter color: 背景颜色
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  public func set(backgroundColor color: UIColor) -> Self {
    self.backgroundColor = color
    return self
  }
  
  /// 设置 `EmptyPageView` 背景点击事件
  ///
  /// - Parameter event: 点击事件
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  @discardableResult
  public func set(tap event: ((_: EmptyPageView) -> Void)?) -> Self {
    _ = self.tapGesture
    eventStore = event
    return self
  }
  
}

// MARK: - for Template
extension EmptyPageView {
  /// 自定义视图模板
  @available(iOS,introduced: 8.0, deprecated: 8.0, renamed: "Template")
  public struct ContentView {
    /// 文本样式模板 `EmptyPageForText`
    @available(iOS,introduced: 8.0, deprecated: 8.0, renamed: "text")
    public static var onlyText: EmptyPageForText { return EmptyPageForText() }
    /// 图片样式模板 `EmptyPageForImage`
    @available(iOS,introduced: 8.0, deprecated: 8.0, renamed: "image")
    public static var onlyImage: EmptyPageForImage {  return EmptyPageForImage() }
    /// 混合样式模板 `EmptyPageForStandard`
    public static var standard: EmptyPageForStandard {  return EmptyPageForStandard() }
  }
  
  /// 自定义视图模板
  public struct Template {
    /// 文本样式模板 `EmptyPageForText`
    public static var text: EmptyPageForText { return EmptyPageForText() }
    /// 图片样式模板 `EmptyPageForImage`
    public static var image: EmptyPageForImage {  return EmptyPageForImage() }
    /// 混合样式模板 `EmptyPageForStandard`
    public static var standard: EmptyPageForStandard {  return EmptyPageForStandard() }
  }

}

// MARK: - class method
extension EmptyPageView {
  
  /// 预设默认背景色
  public static var backColor: UIColor = UIColor.white
  
  /// backgroundView
  public class var backgroundView: EmptyPageView {
    let view = EmptyPageView(frame: UIScreen.main.bounds)
    view.backgroundColor = EmptyPageView.backColor
    return view
  }
  
}

// MARK: - mix methods
extension EmptyPageView {
  /// 将 自定义视图 约束至 `EmptyPageView` 上
  ///
  /// - Parameter view: 空白页内容样式
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  public class func mix(view: UIView) -> EmptyPageView {
    return self.mix(view: view) { (item) in
      let lay1 = NSLayoutConstraint(item: view, attribute: .centerX,
                                    relatedBy: .equal,
                                    toItem: view.superview, attribute: .centerX,
                                    multiplier: 1, constant: 0)
      let lay2 = NSLayoutConstraint(item: view, attribute: .centerY,
                                    relatedBy: .equal,
                                    toItem: view.superview, attribute: .centerY,
                                    multiplier: 1, constant: 0)
      let lay3 = NSLayoutConstraint(item: view, attribute: .width,
                                    relatedBy: .equal,
                                    toItem: view.superview, attribute: .width,
                                    multiplier: 1, constant: 0)
      view.superview?.addConstraints([lay1,lay2,lay3])
    }
  }
  
  /// 将 自定义视图 约束至 `EmptyPageView` 上
  ///
  /// - Parameters:
  ///   - view: 空白页内容样式
  ///   - config: 自定义约束
  /// - Returns: 为支持链式调用,返回 `EmptyPageView`
  public class func mix(view: UIView, _ config: ((_: UIView) -> Void)) -> EmptyPageView {
    let backView = backgroundView
    backView.addSubview(view)
    backView.contentView = view
    view.translatesAutoresizingMaskIntoConstraints = false
    config(view)
    return backView
  }
}


// MARK: - private method
extension EmptyPageView {
  
  /// 点击手势事件
  @objc func event() {
    eventStore?(self)
  }
  
}
