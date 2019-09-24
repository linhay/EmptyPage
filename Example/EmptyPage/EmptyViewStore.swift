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

enum EmptyViewStore: EmptyViewStoreProtocol {

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
