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

open class EmptyPageForImage: UIView,EmptyPageContentViewProtocol {
  
  /// imageView
  public let imageView: UIImageView = {
    let item = UIImageView()
    return item
  }()
  
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

// MARK: - changed layouts
extension EmptyPageForImage {
  
  /// 修改视图水平方向上的间距
  ///
  /// - image:  主图左右间距
  public enum HSpaceType {
    case image
  }
  
  /// 修改视图水平方向上的间距
  ///
  /// - Parameters:
  ///   - space: 指定视图间距
  ///   - value: 修改值
  @discardableResult public func change(hspace type: HSpaceType,value: CGFloat) -> Self {
    
    let fromItem: NSObject = imageView
    let toItem: NSObject = self
    let relation = NSLayoutConstraint.Relation.equal
    let priority = UILayoutPriority(999)

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
      let rightItem = NSLayoutConstraint(item: fromItem, attribute: .left, relatedBy: relation, toItem: toItem, attribute: .left, multiplier: 1, constant: value)
      let leftItem = NSLayoutConstraint(item: fromItem, attribute: .right, relatedBy: relation, toItem: toItem, attribute: .right, multiplier: 1, constant: -value)
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

// MARK: - config for views
extension EmptyPageForImage {
  
  /// 配置图片控件
  ///
  /// - Parameter call: 视图回调
  /// - Returns: 链式调用
  public func config(imageView call: (_: UIImageView) -> ()) -> Self {
    call(imageView)
    return self
  }
  
}

// MARK: - set base info
extension EmptyPageForImage {
  
  /// 设置主图片
  ///
  /// - Parameter value: image
  /// - Returns: 链式调用
  public func set(image value: UIImage?) -> Self{
    setImageAspect(firstImage: value)
    imageView.image = value
    return self
  }
  
  /// 设置图片组
  ///
  /// - Parameters:
  ///   - images: 图片组
  ///   - duration: 播放时长
  ///   - repeatCount: 循环次数
  public func set(images: [UIImage],duration: TimeInterval, repeatCount: Int = 0) -> Self {
    setImageAspect(firstImage: images.first)
    imageView.animationDuration = duration
    imageView.animationRepeatCount = repeatCount
    imageView.animationImages = images
    imageView.startAnimating()
    return self
  }
  
}


extension EmptyPageForImage {
  
  func buildUI() {
    addSubview(imageView)
    let item0 = NSLayoutConstraint(item: imageView,attribute: .centerX,relatedBy: .equal,toItem: self,attribute: .centerX,multiplier: 1,constant: 0)
    
    let item2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageView]-|",
                                               options: NSLayoutFormatOptions(rawValue: 0),
                                               metrics: nil,
                                               views: ["imageView": imageView])
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    addConstraints(item2 + [item0])
  }
  
  func setImageAspect(firstImage: UIImage?) {
    guard let firstImage = firstImage, firstImage.size.width != 0, firstImage.size.height != 0 else { return }
    let constraint = constraints.first(where: { (element) -> Bool in
      return element.firstItem as? NSObject == imageView
        && element.secondItem as? NSObject == imageView
        && element.firstAttribute == .width
        && element.secondAttribute == .width
    })
    
    if let constraint = constraint {
      removeConstraint(constraint)
      addConstraint(constraint)
      updateConstraintsIfNeeded()
    } else {
      let float = firstImage.size.width / firstImage.size.height
      let constraint = NSLayoutConstraint(item: imageView, attribute: .width,
                                          relatedBy: .equal,
                                          toItem: imageView, attribute: .height,
                                          multiplier: float, constant: 0)
      addConstraint(constraint)
      updateConstraintsIfNeeded()
    }
  }
  
}
