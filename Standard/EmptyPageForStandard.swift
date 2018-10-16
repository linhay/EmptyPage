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

open class EmptyPageForStandard: UIView,EmptyPageContentViewProtocol {
  
  /// imageView
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
  
  /// 底部 button
  public let button: UIButton = {
    let item = UIButton()
    item.layer.cornerRadius = 2
    item.backgroundColor = UIColor.blue
    item.addTarget(self, action: #selector(event), for: UIControlEvents.touchUpInside)
    return item
  }()
  
  /// 点击事件
  public var eventStore: (() -> ())?
  
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


// MARK: - config for views
extension EmptyPageForStandard {
  
  /// 配置图片控件
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 链式调用
  public func config(imageView call: (_: UIImageView) -> ()) -> Self {
    call(imageView)
    return self
  }
  
  /// 配置标题控件
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 链式调用
  public func config(titleLabel call: (_: UILabel) -> ()) -> Self {
    call(titleLabel)
    return self
  }
  
  /// 配置文本控件
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 链式调用
  public func config(textLabel call: (_: UILabel) -> ()) -> Self {
    call(textLabel)
    return self
  }
  
  /// 配置按钮控件
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 链式调用
  public func config(button call: (_: UIButton) -> ()) -> Self {
    call(button)
    return self
  }
  
}

// MARK: - set base info
extension EmptyPageForStandard {
  
  /// 设置主图片
  ///
  /// - Parameter value: image
  /// - Returns: 链式调用
  public func set(image value: UIImage?) -> Self{
    imageView.image = value
    setImageAspect(firstImage: value)
    return self
  }
  
  /// 设置图片组
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 播放时长
  ///   - repeatCount: 循环次数
  public func set(images: [UIImage],duration: TimeInterval, repeatCount: Int = 0) -> Self {
    imageView.image = nil
    setImageAspect(firstImage: images.first)
    imageView.animationDuration = duration
    imageView.animationRepeatCount = repeatCount
    imageView.animationImages = images
    return self
  }
  
  /// 设置主标题
  ///
  /// - Parameter value: string
  /// - Returns: 链式调用
  public func set(title: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) -> Self {
    titleLabel.text = title
    titleLabel.textColor = color
    titleLabel.font = font
    return self
  }
  
  /// 设置文本富文本
  ///
  /// - Parameter attributed: 富文本
  public func set(titleAttributed value: NSAttributedString) -> Self {
    titleLabel.attributedText = value
    return self
  }
  
  /// 设置文本
  ///
  /// - Parameter value: string
  /// - Returns: 链式调用
  public func set(text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18)) -> Self {
    textLabel.text = text
    textLabel.textColor = color
    textLabel.font = font
    return self
  }
  
  /// 设置文本富文本
  ///
  /// - Parameter attributed: 富文本
  public func set(textAttributed value: NSAttributedString) -> Self {
    textLabel.attributedText = value
    return self
  }
  
  /// 设置按钮主标题
  ///
  /// - Parameter value: string
  /// - Returns: 链式调用
  public func set(buttonTitle value: String) -> Self {
    button.setTitle(value, for: .normal)
    return self
  }
  
  /// 设置点击事件
  ///
  /// - Parameters:
  ///   - target: target
  ///   - action: 点击事件
  /// - Returns: 链式调用
  public func set(tap target: Any?, action: Selector) -> Self {
    button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    return self
  }
  
  /// 设置点击事件
  ///
  /// - Parameters:
  ///   - tap: 点击事件
  /// - Returns: 链式调用
  public func set(tap event: (() -> ())?) -> Self {
    eventStore = event
    return self
  }
  
}

// MARK: - changed layouts
extension EmptyPageForStandard {
  
  /// 视图高度调整
  ///
  /// - button: 按钮
  public enum HeightType {
    case button
  }
  
  /// 修改视图高度
  ///
  /// - Parameters:
  ///   - space: 指定视图间距
  ///   - value: 修改值
  @discardableResult public func change(height type: HeightType,value: CGFloat) -> Self {
    var targetItem: NSObject
    switch type {
    case .button:
      targetItem = button
    }
    let constraint = constraints.first { (item) -> Bool in
      guard item.firstAttribute == .height, let firstItem = item.firstItem as? NSObject else { return false }
      return firstItem == targetItem
    }
    if let constraint = constraint {
      constraint.constant = value
    }else{
      let constraint = NSLayoutConstraint(item: targetItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: value)
      addConstraint(constraint)
    }
    updateConstraintsIfNeeded()
    return self
  }
  
  /// 垂直方向间距类型
  ///
  /// - imageWithTitle: 图片与标题间距
  /// - titleWithText:  标题与文本间距
  /// - textWithButton: 文本与按钮间距
  public enum VSpaceType {
    case imageTop
    case imageWithTitle
    case titleWithText
    case textWithButton
  }
  
  /// 修改视图垂直方向上的间距
  ///
  /// - Parameters:
  ///   - space: 指定视图间距
  ///   - value: 修改值
  @discardableResult public func change(vspace type: VSpaceType,value: CGFloat) -> Self {
    var item0: NSObject
    var item1: NSObject
    switch type {
    case .imageTop:
      item0 = imageView
      item1 = self
    case .imageWithTitle:
      item0 = titleLabel
      item1 = imageView
    case .titleWithText:
      item0 = textLabel
      item1 = titleLabel
    case .textWithButton:
      item0 = button
      item1 = textLabel
    }
    
    let item = constraints.first { (item) -> Bool in
      guard item.firstAttribute == .top,
        item.secondAttribute == .bottom,
        let firstItem = item.firstItem as? NSObject,
        let secondItem = item.secondItem as? NSObject
        else { return false }
      return firstItem == item0 && secondItem == item1
    }
    item?.constant = value
    updateConstraintsIfNeeded()
    return self
  }
  
  /// 修改视图水平方向上的间距
  ///
  /// - title:  标题左右间距
  /// - text:   文本左右间距
  /// - button: 按钮左右间距
  public enum HSpaceType {
    case image
    case title
    case text
    case button
  }
  
  /// 修改视图水平方向上的间距
  ///
  /// - Parameters:
  ///   - space: 指定视图间距
  ///   - value: 修改值
  @discardableResult public func change(hspace type: HSpaceType,value: CGFloat) -> Self {
    
    var fromItem: NSObject
    let toItem: NSObject = self
    var relation = NSLayoutConstraint.Relation.equal
    
    switch type {
    case .image:
      fromItem = imageView
      relation = .greaterThanOrEqual
    case .title:
      fromItem = titleLabel
    case .text:
      fromItem = textLabel
    case .button:
      fromItem = button
    }
    
    let findItems = constraints.filter { (constraint) -> Bool in
      guard constraint.priority.rawValue == 900,
        let firstItem = constraint.firstItem as? NSObject,
        let secondItem = constraint.secondItem as? NSObject,
        firstItem == fromItem,
        secondItem == toItem
        else { return false }
      return true
    }
    
    if findItems.isEmpty {
      let rightItem = NSLayoutConstraint(item: fromItem, attribute: .left, relatedBy: relation, toItem: toItem, attribute: .left, multiplier: 1, constant: value)
      let leftItem = NSLayoutConstraint(item: fromItem, attribute: .right, relatedBy: relation, toItem: toItem, attribute: .right, multiplier: 1, constant: -value)
      rightItem.priority = UILayoutPriority(rawValue: 900)
      leftItem.priority = UILayoutPriority(rawValue: 900)
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

// MARK: - build ui
extension EmptyPageForStandard {
  
  @objc func event() {
    eventStore?()
  }
  
  func setImageAspect(firstImage: UIImage?) {
    guard let firstImage = firstImage, firstImage.size.width != 0, firstImage.size.height != 0 else { return }
    let float = firstImage.size.width / firstImage.size.height
    let item = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: float, constant: 0)
    if let constraint = constraints.first(where: { (element) -> Bool in
      return element.firstItem as? NSObject == imageView
        && element.secondItem as? NSObject == imageView
    }) {
      removeConstraint(constraint)
    }
    addConstraint(item)
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
      constraints.append(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
      constraints.append(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20))
      change(hspace: .image, value: 15)
    }
    
    do {
      constraints.append(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10))
      change(hspace: .title, value: 15)
    }
    
    do {
      constraints.append(NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5))
      change(hspace: .text, value: 15)
    }
    
    do {
      constraints.append(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: textLabel, attribute: .bottom, multiplier: 1, constant: 10))
      constraints.append(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20))
      change(hspace: .button, value: 15)
    }
    

    addConstraints(constraints)
  }
  
  
}
