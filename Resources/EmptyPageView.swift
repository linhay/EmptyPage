//
//  EmptyPageView.swift
//  B7iOSBuyer
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

class BuyerEmptyPage { }

protocol EmptyPageViewProtocol: class {
  
}

public typealias EmptyEvent = (()->())?

public enum EmptyPage3Style {
  case title
  case text
}

extension EmptyPageViewProtocol {
  static var initFromNib: Self {
    return Bundle(for: BuyerEmptyPage.self).loadNibNamed(String(describing: self),
                                                         owner: nil,
                                                         options: nil)?.first! as! Self
  }
}

public class EmptyPageView: UIView {
  
  class var backgroundView: EmptyPageView {
    let view = EmptyPageView(frame: UIScreen.main.bounds)
    view.backgroundColor = UIColor(red: 244 / 255, green: 244 / 255, blue: 244 / 255, alpha: 1)
    return view
  }
  
  class func mix(view: UIView) -> EmptyPageView {
    let backView = backgroundView
    backView.addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    let lay1 = NSLayoutConstraint(item: view,
                                  attribute: NSLayoutAttribute.centerX,
                                  relatedBy: NSLayoutRelation.equal,
                                  toItem: view.superview,
                                  attribute: NSLayoutAttribute.centerX,
                                  multiplier: 1,
                                  constant: 0)
    
    let lay2 = NSLayoutConstraint(item: view,
                                  attribute: NSLayoutAttribute.centerY,
                                  relatedBy: NSLayoutRelation.equal,
                                  toItem: view.superview,
                                  attribute: NSLayoutAttribute.centerY,
                                  multiplier: 1,
                                  constant: 0)
    
    let lay3 = NSLayoutConstraint(item: view,
                                  attribute: NSLayoutAttribute.width,
                                  relatedBy: NSLayoutRelation.equal,
                                  toItem: view.superview,
                                  attribute: NSLayoutAttribute.width,
                                  multiplier: 1,
                                  constant: 0)
    
    backView.addConstraints([lay1,lay2,lay3])
    
    return backView
  }
  
}

extension EmptyPageView {
  
  public class func onlyText(style: EmptyPage3Style = .title,
                             text: String) -> EmptyPageView {
    let view = EmptyPageStyle3View.initFromNib
    view.config(style: style, text: text)
    return mix(view: view)
  }
  
  
  public class func onlyImages(images: [UIImage],
                               duration: TimeInterval = 0,
                               repeatCount: Int = 0) -> EmptyPageView {
    let view = EmptyPageStyle2View.initFromNib
    view.config(images: images)
    return mix(view: view)
  }
  
  public class func standard(image: UIImage,
                             title: String,
                             text: String,
                             btnTitle: String,
                             event: EmptyEvent) -> EmptyPageView {
    let view = EmptyPageStyle1View.initFromNib
    view.config(images: [image],
                title: title,
                text: text,
                btnTitle: btnTitle,
                event: event)
    return mix(view: view)
  }
  
  public class func standard(images: [UIImage],
                             duration: TimeInterval = 0,
                             repeatCount: Int = 0,
                             title: String,
                             text: String,
                             btnTitle: String,
                             event: EmptyEvent) -> EmptyPageView {
    let view = EmptyPageStyle1View.initFromNib
    view.config(images: images,
                duration: duration,
                repeatCount: repeatCount,
                title: title,
                text: text,
                btnTitle: btnTitle,
                event: event)
    return mix(view: view)
  }
}







