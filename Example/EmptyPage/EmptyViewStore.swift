//
//  EmptyViewStore.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

protocol EmptyViewStoreProtocol {
    var emptyView: EmptyPageView { get }
}

extension EmptyPage where Base: UIScrollView {
    /// 添加空白页视图
    ///
    /// - Parameter view: 模板视图
    func setEmpty(_ template: EmptyViewStoreProtocol?) {
        base.ep.setEmpty(template?.emptyView)
    }

}


enum EmptyViewStore: EmptyViewStoreProtocol {

    static let dz = DZEmptyStyle.self
    static let template = TemplateStyle.self

    case loading

    var emptyView: EmptyPageView {
        switch self {
        case .loading:
            return EmptyPageView.Template.image
                .set(image: UIImage(named: "load-0"))
                .config { (item) in
                    let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                    animation.fromValue = CGFloat.pi * 2
                    animation.toValue = 0
                    animation.duration = 2
                    animation.autoreverses = false
                    animation.fillMode = CAMediaTimingFillMode.forwards
                    animation.repeatCount = Float.infinity
                    item.layer.add(animation, forKey: nil)
            }
            .mix()
        }
    }
    
}

enum TemplateStyle: EmptyViewStoreProtocol {

    case text

    var emptyView: EmptyPageView {
        switch self {
        case .text:
            return EmptyPageView.Template.text
                .set(text: "纯文字")
                .mix()
        }
    }
}

enum DZEmptyStyle {

    case px500
    case airbnb
    case appStore
    case camera
    case dropbox
    case fackbook
    case fancy
    case foursquare
    case icloud
    case instagram
    case itunesConnect
    case kickstarter
    case path
    case photo
    case podcasts
    case remote
    case safari
    case skype
    case slack
    case tumblr

}
