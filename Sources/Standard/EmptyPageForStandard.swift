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

/// `EmptyPageForStandard` 混合样式模板
open class EmptyPageForStandard: UIView,EmptyPageContentViewProtocol {
  
  // MARK: - Public property
  /// 图片 imageView
  public let imageView: UIImageView = {
    let item = UIImageView()
    return item
  }()
  
  /// 标题 Label
  public let titleLabel: UILabel = {
    let item = UILabel()
    item.textAlignment = .center
    item.textColor = UIColor.black
    return item
  }()
  
  /// 描述 Label
  public let textLabel: UILabel = {
    let item = UILabel()
    item.numberOfLines = 0
    item.textAlignment = .center
    item.textColor = UIColor.gray
    return item
  }()
  
  /// 底部按钮 button
  public let button: UIButton = {
    let item = UIButton()
    item.layer.cornerRadius = 2
    item.backgroundColor = UIColor.blue
    item.addTarget(self, action: #selector(event), for: UIControlEvents.touchUpInside)
    return item
  }()
  
  /// 点击事件
  public var eventStore: (() -> ())?
  
  // MARK: - Override
  public init() {
    super.init(frame: CGRect.zero)
    buildUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
  
  open override func willMove(toWindow newWindow: UIWindow?) {
    super.willMove(toWindow: newWindow)
    guard imageView.image == nil else { return }
    newWindow == nil ? imageView.stopAnimating() : imageView.startAnimating()
  }
  
}

// MARK: 调整 layout 相关枚举与函数
extension EmptyPageForStandard {
  
  /// 视图高度调整
  ///
  /// - button: 按钮 default: 自适应
  public enum HeightType {
    case button
  }
  
  /// 修改视图高度
  ///
  /// - Parameters:
  ///   - type: 调整类型,可查阅: `EmptyPageForStandard.HeightType`
  ///   - value: 调整值
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func change(height type: HeightType,value: CGFloat) -> Self {
    var targetItem: NSObject
    switch type {
    case .button:
      targetItem = button
    }
    let constraint = constraints.first { (item) -> Bool in
      return item.firstAttribute == .height && item.firstItem === targetItem
    }
    
    if let constraint = constraint {
      constraint.constant = value
    }else{
      let constraint = NSLayoutConstraint(item: targetItem, attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil, attribute: .notAnAttribute,
                                          multiplier: 1,
                                          constant: value)
      addConstraint(constraint)
    }
    updateConstraintsIfNeeded()
    return self
  }
  
  /// 垂直方向间距类型
  ///
  /// - imageWithTitle: 图片与标题间距 default: 10
  /// - titleWithText:  标题与文本间距 default: 5
  /// - textWithButton: 文本与按钮间距 default: 10
  public enum VSpaceType {
    case imageTop
    case imageWithTitle
    case titleWithText
    case textWithButton
  }
  
  /// 修改视图垂直方向上的间距
  ///
  /// - Parameters:
  ///   - type: 调整类型,可查阅: `EmptyPageForStandard.VSpaceType`
  ///   - value: 调整值
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func change(vspace type: VSpaceType,value: CGFloat) -> Self {
    var fromItem: NSObject
    var toItem: NSObject
    var secondAttribute: NSLayoutConstraint.Attribute = .bottom
    switch type {
    case .imageTop:
      fromItem = imageView
      toItem = self
      secondAttribute = .top
    case .imageWithTitle:
      fromItem = titleLabel
      toItem = imageView
    case .titleWithText:
      fromItem = textLabel
      toItem = titleLabel
    case .textWithButton:
      fromItem = button
      toItem = textLabel
    }
    
    let findItem = constraints.first { (item) -> Bool in
      return item.firstAttribute == .top
        && item.secondAttribute == secondAttribute
        && item.firstItem === fromItem
        && item.secondItem === toItem
    }
    
    if let findItem = findItem {
      findItem.constant = value
    }else{
      let item = NSLayoutConstraint(item: fromItem, attribute: .top,
                                    relatedBy: .equal,
                                    toItem: toItem, attribute: secondAttribute,
                                    multiplier: 1,
                                    constant: value)
      addConstraint(item)
    }
    
    updateConstraintsIfNeeded()
    return self
  }
  
  /// 修改视图水平方向上的间距
  ///
  /// - image:  主图左右间距 default: 无约束
  /// - title:  标题左右间距 default: 15
  /// - text:   文本左右间距 default: 15
  /// - button: 按钮左右间距 default: 15
  public enum HSpaceType {
    case image
    case title
    case text
    case button
  }
  
  /// 修改视图水平方向上的间距
  ///
  /// - Parameters:
  ///   - type: 调整类型,可查阅: `EmptyPageForStandard.HSpaceType`
  ///   - value: 调整值
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func change(hspace type: HSpaceType,value: CGFloat) -> Self {
    
    var fromItem: NSObject
    let toItem: NSObject = self
    let priority = UILayoutPriority(999)
    switch type {
    case .image:
      fromItem = imageView
    case .title:
      fromItem = titleLabel
    case .text:
      fromItem = textLabel
    case .button:
      fromItem = button
    }
    
    let findItems = constraints.filter { (constraint) -> Bool in
      guard constraint.priority == priority,
        let firstItem = constraint.firstItem as? NSObject,
        let secondItem = constraint.secondItem as? NSObject,
        firstItem == fromItem,
        secondItem == toItem
        else { return false }
      return true
    }
    
    if findItems.isEmpty {
      let rightItem = NSLayoutConstraint(item: fromItem, attribute: .left,
                                         relatedBy: .equal,
                                         toItem: toItem, attribute: .left,
                                         multiplier: 1, constant: value)
      let leftItem = NSLayoutConstraint(item: fromItem, attribute: .right,
                                        relatedBy: .equal,
                                        toItem: toItem, attribute: .right,
                                        multiplier: 1, constant: -value)
      rightItem.priority = priority
      leftItem.priority = priority
      addConstraints([rightItem, leftItem])
    }else{
      findItems.forEach { (item) in
        item.constant = item.firstAttribute == .left ? value : -value
      }
    }
    
    updateConstraintsIfNeeded()
    return self
  }
  
}

// MARK: 深度配置元素 相关函数
extension EmptyPageForStandard {
  
  /// 配置图片元素
  ///
  /// - Parameter call: 元素回调, 回调 `EmptyPageForStandard.imageView`
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func config(imageView call: (_: UIImageView) -> ()) -> Self {
    call(imageView)
    return self
  }
  
  /// 配置标题元素
  ///
  /// - Parameter call: 元素回调, 回调 `EmptyPageForStandard.titleLabel`
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func config(titleLabel call: (_: UILabel) -> ()) -> Self {
    call(titleLabel)
    return self
  }
  
  /// 配置文本元素
  ///
  /// - Parameter call: 元素回调, 回调 `EmptyPageForStandard.textLabel`
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func config(textLabel call: (_: UILabel) -> ()) -> Self {
    call(textLabel)
    return self
  }
  
  /// 配置底部按钮元素
  ///
  /// - Parameter call: 元素回调, 回调 `EmptyPageForStandard.button`
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func config(button call: (_: UIButton) -> ()) -> Self {
    call(button)
    return self
  }
  
}

// MARK: 轻度配置元素 相关函数
extension EmptyPageForStandard {
  
  /// 设置 `EmptyPageForStandard.imageView`
  ///
  /// - Parameter value: 图片
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(image value: UIImage?) -> Self{
    imageView.image = value
    setImageAspect(firstImage: value)
    return self
  }
  
  /// 设置 `EmptyPageForStandard.imageView`
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 播放时长
  ///   - repeatCount: 循环次数
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(images: [UIImage],duration: TimeInterval, repeatCount: Int = 0) -> Self {
    imageView.image = nil
    setImageAspect(firstImage: images.first)
    imageView.animationDuration = duration
    imageView.animationRepeatCount = repeatCount
    imageView.animationImages = images
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.titleLabel`
  ///
  /// - Parameters:
  ///   - title: 文本
  ///   - color: 文本颜色 default: UIColor.black
  ///   - font:  字体 default: UIFont.systemFont(ofSize: 18)
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(title: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) -> Self {
    titleLabel.text = title
    titleLabel.textColor = color
    titleLabel.font = font
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.titleLabel`
  ///
  /// - Parameter value: 富文本
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(titleAttributed value: NSAttributedString) -> Self {
    titleLabel.attributedText = value
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.textLabel`
  ///
  /// - Parameters:
  ///   - title: 文本
  ///   - color: 文本颜色 default: UIColor.black
  ///   - font:  字体 default: UIFont.systemFont(ofSize: 18)
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) -> Self {
    textLabel.text = text
    textLabel.textColor = color
    textLabel.font = font
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.textLabel`
  ///
  /// - Parameter value: 富文本
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(textAttributed value: NSAttributedString) -> Self {
    textLabel.attributedText = value
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.button`
  ///
  /// - Parameter value: 标题
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(buttonTitle value: String) -> Self {
    button.setTitle(value, for: .normal)
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.button` 点击事件
  ///
  /// - Parameters:
  ///   - target: target
  ///   - action: 点击事件
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(tap target: Any?, action: Selector) -> Self {
    button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    return self
  }
  
  
  /// 设置 `EmptyPageForStandard.button` 点击事件
  ///
  /// - Parameter event: 点击事件
  /// - Returns: 为支持链式调用,返回 `EmptyPageForStandard`
  @discardableResult
  public func set(tap event: (() -> ())?) -> Self {
    eventStore = event
    return self
  }
  
}



// MARK: - build ui
extension EmptyPageForStandard {
  
  @objc func event() {
    eventStore?()
  }
  
  
  func setImageAspect(firstImage: UIImage?) {
    guard let firstImage = firstImage, firstImage.size.width != 0, firstImage.size.height != 0 else { return }
    let constraint = constraints.first(where: { (element) -> Bool in
      return element.firstItem === imageView
        && element.secondItem === imageView
        && element.firstAttribute == .width
        && element.secondAttribute == .height
    })
    
    if let constraint = constraint { removeConstraint(constraint) }
    let float = firstImage.size.width / firstImage.size.height
    let newConstraint = NSLayoutConstraint(item: imageView, attribute: .width,
                                           relatedBy: .equal,
                                           toItem: imageView, attribute: .height,
                                           multiplier: float, constant: 0)
    addConstraint(newConstraint)
    updateConstraintsIfNeeded()
  }
  
  func buildUI() {
    addSubview(imageView)
    addSubview(titleLabel)
    addSubview(textLabel)
    addSubview(button)
    buildLayouts()
  }
  
  func buildLayouts() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    var constraints = [NSLayoutConstraint]()
    
    do {
      _ = change(vspace: .imageTop, value: 20)
      constraints.append(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    do {
      _ = change(vspace: .imageWithTitle, value: 10)
      _ = change(hspace: .title, value: 15)
    }
    
    do {
      _ = change(vspace: .titleWithText, value: 5)
      _ = change(hspace: .text, value: 15)
    }
    
    do {
      _ = change(vspace: .textWithButton, value: 10)
      _ = change(hspace: .button, value: 15)
      constraints.append(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20))
    }
    
    addConstraints(constraints)
  }
  
  
}
