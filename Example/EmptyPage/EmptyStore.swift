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

enum TemplateSet {
    
    static func standard1(tapEvent: (() -> Void)?) -> EmptyPageTemplateProtocol {
        EmptyPageView.Template.standard
            .config(imageView: {
                $0.set(image: UIImage(named: "404"))
                $0.backgroundColor = UIColor.yellow
                $0.layout(size: .init(width: 160, height: 160))
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
                $0.set(tapEvent: tapEvent)
            })
            .layout(view: .imageView, types: .width(160), .height(160))
            .layout(view: .button, types: .height(30))
            .layout(view: .textLabel, types: .afterSpac(10))
            .layout(view: .titleLabel, types: .afterSpac(10))
    }
    
    static func image_normal() -> EmptyPageTemplateProtocol {
        EmptyPageView.Template.image.set(image: UIImage(named: "empty"))
    }
    
    static func image_animate() -> EmptyPageTemplateProtocol {
        let images = (0...47).compactMap({ UIImage(named: "image_animate_\($0)") })
        return EmptyPageView.Template.image.set(images: images, duration: 2)
    }
    
    static func text_normal() -> EmptyPageTemplateProtocol {
        EmptyPageView.Template.text.set(text: "搜索不到数据 \n" + "No data found")
    }
    
    static func text_attributed() -> EmptyPageTemplateProtocol {
        let cn = NSAttributedString(string: "搜索不到数据 \n",
                                    attributes: [.font(.systemFont(ofSize: 15, weight: .medium)),
                                                 .paragraphStyle([.minimumLineHeight(20),
                                                                  .maximumLineHeight(20)])])
        let en = NSAttributedString(string: "No data found", attributes: [.foregroundColor(UIColor.red),
                                                                          .font(.systemFont(ofSize: 20, weight: .medium)),
                                                                          .paragraphStyle([.minimumLineHeight(20),
                                                                                           .maximumLineHeight(20)])])
        return EmptyPageView.Template.text.set(attributed: cn + en).config { view in
            view.textAlignment = .center
        }
    }
    
}
