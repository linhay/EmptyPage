//
//  EmptyManger.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import Stem
import SnapKit

enum Dribbble: String, CaseIterable {
    
    case illustration
    
    var website: String { "dribbble.com" }
    var link: String {
        switch self {
        case .illustration:
            return "https://dribbble.com/shots/2586577-404-page-Illustration"
        }
    }
    
    func view() -> EmptyPageView {
        switch self {
        case .illustration:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "404")!) })
                .layout(view: .titleLabel, types: .afterSpac(0))
                .config(titleLabel: {
                    $0.set(text: "FILE NOT FOUND",
                           color: UIColor("#849aac"),
                           font: UIFont.boldSystemFont(ofSize: 18))
                })
                .config(textLabel: {
                    $0.set(text: "Lorem ipsum dolor sit amet.\nconectetur adipscing elit sed do eiusmod",
                           color: UIColor("#c5cfd7"))
                })
                .config(button: {
                    $0.isHidden = true
                })
                .mix()
                .set(backgroundColor: UIColor("#f5f7f9"))
        }
    }
}

enum EmptyStat: String, CaseIterable {
    case _167120251047 = "167120251047"
    case _162198623343 = "162198623343"
    
    var website: String { "emptystat.es" }
    var link: String { "http://emptystat.es/image/\(rawValue)" }
    
    func view() -> EmptyPageView {
        switch self {
        case ._162198623343:
            return EmptyPageView.Template.standard
                .layout(view: .button, types: .insets(80))
                .layout(view: .button, types: .height(60))
                .layout(view: .imageView, types: .insets(15))
                .config(imageView: {
                    $0.set(image: UIImage(named: "empty-1002")!)
                })
                .config(titleLabel: {
                    $0.set(text: "Connection failure",
                           color: UIColor.black,
                           font: UIFont.boldSystemFont(ofSize: 24))
                }).config(textLabel: {
                    $0.set(text: "Something has gone wrong with the internet connection. Let's give it another shot.",
                           color: UIColor.black,
                           font: UIFont.systemFont(ofSize: 15))
                })
                .config(button: {
                    $0.setTitle("TRY AGAIN", for: .normal)
                    $0.backgroundColor = UIColor("#0180bf")
                    $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
                })
                .mix()
        case ._167120251047:
            return EmptyPageView.Template.standard
                .config(imageView: {
                    $0.set(image: UIImage(named: "empty-1001")!)
                })
                .config(titleLabel: {
                    $0.set(text: "Nobody is following",
                           color: UIColor("#536571"),
                           font: UIFont.boldSystemFont(ofSize: 18))
                })
                .config(textLabel: {
                    $0.set(text: "Following people helps you keep what they're saying and recommending.",
                           color: UIColor("#c3ccd1"))
                })
                .config(button: {
                    $0.setTitle("Find interesting people to follow >>", for: .normal)
                    $0.layer.borderColor = UIColor("#2ca3fa").cgColor
                    $0.layer.borderWidth = 1
                    $0.layer.cornerRadius = 5
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    $0.backgroundColor = .white
                    $0.setTitleColor(UIColor("#2ca3fa"), for: .normal)
                    $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
                })
                .layout(view: .button, types: .height(30))
                .layout(view: .textLabel, types: .afterSpac(10))
                .layout(view: .titleLabel, types: .afterSpac(10))
                .mix()
        }
    }
    
}

struct DemoSet {
    
    func standard(tapEvent: ((EmptyPageForStandard) -> Void)?) -> EmptyPageView {
        return EmptyPageView.Template.standard
            .config(imageView: {
                $0.set(image: UIImage(named: "404"))
                $0.backgroundColor = UIColor.yellow
            })
            .config(titleLabel: {
                $0.set(text: "Nobody is following",
                       color: UIColor("#536571"),
                       font: UIFont.boldSystemFont(ofSize: 18))
            })
            .config(textLabel: {
                $0.set(text: "Following people helps you keep what they're saying and recommending.",
                       color: UIColor("#c3ccd1"))
            })
            .config(button: {
                $0.layer.borderColor = UIColor("#2ca3fa").cgColor
                $0.layer.borderWidth = 1
                $0.layer.cornerRadius = 5
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                $0.backgroundColor = .white
                $0.setTitleColor(UIColor("#2ca3fa"), for: .normal)
                $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
                $0.setTitle("Find interesting people to follow >>", for: .normal)
            })
            .layout(view: .button, types: .height(30))
            .layout(view: .textLabel, types: .afterSpac(10))
            .layout(view: .titleLabel, types: .afterSpac(10))
            .mix()
            .set(backgroundColor: UIColor.white)
        
    }
    
}

class EmptyStore {
    
    static let dzn = DZNEmptyDataSet.self
    static let demo = DemoSet()
    
    class var loading: EmptyPageView{
        return EmptyPageView.Template.image
            .layout(size: .init(width: 20, height: 20))
            .config(imageView: {
                $0.set(image: UIImage(named: "load-0"))
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = CGFloat.pi * 2
                animation.toValue = 0
                animation.duration = 2
                animation.autoreverses = false
                animation.fillMode = CAMediaTimingFillMode.forwards
                animation.repeatCount = Float.infinity
                $0.layer.add(animation, forKey: nil)
            })
            .mix()
    }
    
}


/// 线程延时
public func sleep(_ time: Double,mainCall:@escaping ()->()) {
    let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
    DispatchQueue.main.asyncAfter(deadline: time) {
        mainCall()
    }
}

