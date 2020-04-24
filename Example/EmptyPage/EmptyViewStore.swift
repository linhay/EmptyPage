//
//  EmptyViewStore.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import SVProgressHUD
import Stem

protocol EmptyViewStoreProtocol {
    var emptyView: EmptyPageView { get }
}

extension EmptyPage where Base: UIScrollView {

    /// 添加空白页视图
    ///
    /// - Parameter view: 模板视图
    func setEmpty(_ template: EmptyViewStoreProtocol?) {
        self.setEmpty(template?.emptyView)
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
    case image
    case standard
    
    var emptyView: EmptyPageView {
        switch self {
        case .text:
            return EmptyPageView.Template.text
                .set(text: "纯文字")
                .mix()
        case .image:
            return EmptyPageView.Template.image
                .set(image: UIImage(named: "empty-1002")!)
                .mix()
        case .standard:
            let images = (0...3).map { (item) -> UIImage in
                return UIImage(named: "load-\(item)")!
            }
            let attributed = "Connection".st.attributes([.font(UIFont.boldSystemFont(ofSize: 30)),
                                                         .foregroundColor(.red)])
                + " Failure".st.attributes([.font(UIFont.systemFont(ofSize: 20)),
                                            .foregroundColor(.darkText)])
            
            return EmptyPageView.Template.standard
                .config(button: { (item) in
                    item.setTitleColor(.white, for: .normal)
                    item.titleLabel?.font = .boldSystemFont(ofSize: 18)
                    item.backgroundColor = .darkGray
                })
                .set(images: images, duration: 1.5, repeatCount: 0)
                .set(titleAttributed: attributed)
                .set(textAttributed: attributed)
                .set(text: "wait for a minture")
                .set(buttonTitle: "按钮文本")
                .mix()
        }
    }
}

enum DZEmptyStyle: EmptyViewStoreProtocol, CaseIterable {
    
    struct Item {
        let title: String
        let subtitle: String
        let image: UIImage
    }
    
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
    
    func tapEvent() -> ((EmptyPageForStandard) -> Void)? {
        return { (item) in
            
        }
    }
    
    func backgroundTapEvent() -> ((EmptyPageView) -> Void)? {
        return { (item) in
            if let item = item.contentView as? EmptyPageForStandard {
                self.tapEvent()?(item)
            }
        }
    }
    
    var emptyView: EmptyPageView {
        switch self {
        case .px500:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_500px"))
                .set(title: "No Photos",
                     color: UIColor("#545454"),
                     font: UIFont.boldSystemFont(ofSize: 17))
                .set(text: "Get started by uploading a photo.",
                     color: UIColor("#545454"),
                     font: UIFont.boldSystemFont(ofSize: 15))
                .change(vspace: .titleWithText, value: 15)
                .mix({ (item) in
                    item.snp.makeConstraints({ (make) in
                        make.left.equalToSuperview().offset(15)
                        make.right.equalToSuperview().offset(-15)
                        make.centerY.equalToSuperview().offset(15)
                    })
                })
                .set(tap: backgroundTapEvent())
                .set(backgroundColor: UIColor.black)
        case .airbnb:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_airbnb"))
                .set(title: "No Messages",
                     color: UIColor("#c9c9c9"),
                     font: UIFont(name: "HelveticaNeue-Light", size: 22)!)
                .set(text: "When you have messages, you’ll see them here.",
                     color: UIColor("#cfcfcf"),
                     font: UIFont.boldSystemFont(ofSize: 13))
                .config(button: { (item) in
                    item.setTitle("Start Browsing", for: .normal)
                    item.setTitleColor(UIColor("#6bceff"), for: .normal)
                    item.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    item.backgroundColor = UIColor.white
                })
                .set(tap: tapEvent())
                .change(vspace: .imageWithTitle, value: 24)
                .change(vspace: .textWithButton, value: 24)
                .change(vspace: .titleWithText, value: 24)
                .mix()
                .set(tap: backgroundTapEvent())
        case .appStore:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_appstore"))
                .set(text: "There are no results for “wwdc2014”.",
                     color: UIColor("#333333"),
                     font: UIFont.boldSystemFont(ofSize: 14))
                .change(vspace: .imageWithTitle, value: 34)
                .mix()
                .set(tap: backgroundTapEvent())
        case .camera:
            return EmptyPageView.Template.standard
                .set(title: "Please Allow Photo Access",
                     color: UIColor("#5f6978"),
                     font: UIFont.boldSystemFont(ofSize: 18))
                .set(text: "This allows you to share photos from your library and save photos to your camera roll.",
                     color: UIColor("#5f6978"),
                     font: UIFont.systemFont(ofSize: 14))
                .set(buttonTitle: "Continue")
                .set(tap: tapEvent())
                .mix()
                .set(tap: backgroundTapEvent())
        case .dropbox:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_dropbox"))
                .set(title: "Star Your Favorite Files",
                     color: UIColor("#25282b"),
                     font: UIFont.boldSystemFont(ofSize: 17))
                .set(text: "Favorites are saved for offline access.",
                     color: UIColor("#7b8994"),
                     font: UIFont.systemFont(ofSize: 14.5))
                .set(buttonTitle: "Learn more", color: UIColor("#48a1ea"),for: UIControl.State.normal)
                .set(tap: tapEvent())
                .mix()
                .set(backgroundColor: UIColor("#f0f3f5"))
                .set(tap: backgroundTapEvent())
        case .fackbook:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_facebook"))
                .set(title: "No friends to show.",
                     color: UIColor("#acafbd"),
                     font: UIFont.boldSystemFont(ofSize: 22))
                .change(vspace: .imageWithTitle, value: 30)
                .mix()
                .set(backgroundColor: UIColor("#eceef7"))
                .set(tap: backgroundTapEvent())
        case .fancy:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_fancy"))
                .set(title: "No Owns yet",
                     color: UIColor("#494c53"),
                     font: UIFont.boldSystemFont(ofSize: 14))
                .set(text: "Tap Add to List and add things to Owns",
                     color: UIColor("#7a7d83"),
                     font: UIFont.boldSystemFont(ofSize: 13))
                .mix()
                .set(backgroundColor: UIColor("#f0f0f0"))
                .set(tap: backgroundTapEvent())
        case .foursquare:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_foursquare"))
                .set(text: "Nobody has liked or commented on your check-ins yet.",
                     color: UIColor("#cecbc6"),
                     font: UIFont.systemFont(ofSize: 14))
                .change(height: .button, value: 36)
                .change(hspace: .text, value : 15)
                .change(vspace: .textWithButton, value: 15)
                .change(vspace: .imageWithTitle, value: 15)
                .config(button: { (item) in
                    item.setTitle("Add friends to get started!", for: .normal)
                    item.setTitleColor(UIColor("#00aeef"), for: .normal)
                    item.layer.cornerRadius = 18
                    item.layer.borderColor = item.titleColor(for: .normal)!.cgColor
                    item.layer.borderWidth = 1
                    item.layer.masksToBounds = true
                })
                .set(tap: tapEvent())
                .mix()
                .set(backgroundColor: UIColor("#fcfcfa"))
                .set(tap: backgroundTapEvent())
        case .icloud:
            return EmptyPageView.Template.standard
                .set(title: "iCloud Photo Sharing",
                     color: UIColor("#999999"),
                     font: UIFont.systemFont(ofSize: 30))
                .set(text: "Share photos and videos with just the people you choose, and let them add photos, videos, and comments.",
                     color: UIColor("#999999"),
                     font: UIFont.systemFont(ofSize: 18))
                .change(hspace: .button, value: 100)
                .change(hspace: .text, value: 40)
                .change(vspace: .titleWithText, value: 15)
                .change(vspace: .textWithButton, value: 20)
                .config(button: { (item) in
                    item.setTitle("Create New Stream", for: .normal)
                    item.setTitleColor(UIColor("#999999"), for: .normal)
                    item.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    item.layer.cornerRadius = 2
                    item.layer.borderColor = item.titleColor(for: .normal)!.cgColor
                    item.layer.borderWidth = 1
                    item.layer.masksToBounds = true
                })
                .set(tap: tapEvent())
                .mix()
                .set(tap: backgroundTapEvent())
        case .instagram:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_instagram"))
                .set(title: "Instagram Direct",
                     color: UIColor("#444444"),
                     font: UIFont(name: "HelveticaNeue-Light", size: 26)!)
                .set(text: "Send photos and videos directly to your friends. Only the people you send to can see these posts.",
                     color: UIColor("#444444"),
                     font: UIFont.systemFont(ofSize: 16))
                .change(vspace: .imageWithTitle, value: 24)
                .change(vspace: .titleWithText, value: 24)
                .change(hspace: .text, value: 20)
                .change(hspace: .title, value: 20)
                .mix()
                .set(tap: backgroundTapEvent())
        case .itunesConnect:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_itunes_connect"))
                .set(title: "No Favorites",
                     color: UIColor.lightGray,
                     font: UIFont.systemFont(ofSize: 22))
                .set(text: "To add a favorite, tap the star icon next to an App's name.",
                     color: UIColor.lightGray,
                     font: UIFont.systemFont(ofSize: 14))
                .change(vspace: .imageWithTitle, value: 9)
                .change(vspace: .titleWithText, value: 9)
                .change(hspace: .text, value: 40)
                .change(hspace: .title, value: 40)
                .mix()
                .set(tap: backgroundTapEvent())
        case .kickstarter:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_kickstarter"))
                .set(title: "Activity empty",
                     color: UIColor("#828587"),
                     font: UIFont.systemFont(ofSize: 16))
                .set(text: "When you back a project or follow a friend, their activity will show up here.",
                     color: UIColor("#828587"),
                     font: UIFont.systemFont(ofSize: 14))
                .config(button: { (item) in
                    item.setTitle("Discover projects", for: .normal)
                    item.setTitleColor(UIColor.white, for: .normal)
                    item.backgroundColor = UIColor.gray
                    item.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    item.layer.cornerRadius = 2
                    item.layer.masksToBounds = true
                })
                .set(tap: tapEvent())
                .change(vspace: .imageWithTitle, value: 15)
                .change(vspace: .titleWithText, value: 15)
                .change(hspace: .text, value: 40)
                .change(hspace: .title, value: 40)
                .change(hspace: .button, value: 40)
                .change(height: .button, value: 45)
                .mix()
                .set(backgroundColor: UIColor("#f7fafa"))
                .set(tap: backgroundTapEvent())
        case .path:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_path"))
                .set(title: "Message Your Friends",
                     color: UIColor.white,
                     font: UIFont.boldSystemFont(ofSize: 16))
                .set(text: "Send a message or create a group.",
                     color: UIColor("#a6978d"),
                     font: UIFont.systemFont(ofSize: 14))
                .change(vspace: .imageWithTitle, value: 1)
                .change(vspace: .titleWithText, value: 1)
                .mix()
                .set(backgroundColor: UIColor("#726d67"))
                .set(tap: backgroundTapEvent())
        case .photo:
            return EmptyPageView.Template.standard
                .set(title: "No Photos or Videos",
                     color: UIColor("#999999"),
                     font: UIFont.systemFont(ofSize: 30))
                .set(text: "You can sync photos and videos onto your iPhone using iTunes.",
                     color: UIColor("#999999"),
                     font: UIFont.systemFont(ofSize: 18))
                .change(hspace: .text, value: 40)
                .change(vspace: .titleWithText, value: 15)
                .mix()
                .set(tap: backgroundTapEvent())
        case .podcasts:
            return EmptyPageView.Template.standard
                .set(title: "No Podcasts",
                     color: UIColor("#999999"),
                     font: UIFont.systemFont(ofSize: 30))
                .set(text: "You can subscribe to podcasts in Top Charts or Featured.",
                     color: UIColor("#999999"),
                     font: UIFont.systemFont(ofSize: 18))
                .change(hspace: .text, value: 35)
                .change(vspace: .titleWithText, value: 35)
                .mix()
                .set(tap: backgroundTapEvent())
        case .remote:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_remote"))
                .set(title: "Cannot Connect to a Local Network",
                     color: UIColor("#555555"),
                     font: UIFont(name: "HelveticaNeue-Medium", size: 18)!)
                .set(text: "You must connect to a Wi-Fi network to control iTunes or Apple TV",
                     color: UIColor("#555555"),
                     font: UIFont(name: "HelveticaNeue-Medium", size: 11.75)!)
                .change(hspace: .text, value: 20)
                .mix()
                .set(tap: backgroundTapEvent())
        case .safari:
            return EmptyPageView.Template.text
                .set(text: "Safari cannot open the page because your iPhone is not connected to the Internet.",
                     color: UIColor("#7d7f7f"),
                     font: UIFont.systemFont(ofSize: 18))
                .change(hspace: .text, value: 20)
                .mix()
                .set(tap: backgroundTapEvent())
        case .skype:
            let attr = NSMutableAttributedString(string: "Keep all your favorite people together",
                                                 attributes: [.font : UIFont(name: "HelveticaNeue-Light", size: 17.75)!,
                                                              .foregroundColor: UIColor("#a6c3d1")])
            let attr2 = NSAttributedString(string: "\nadd favorites",
                                           attributes: [.font : UIFont(name: "HelveticaNeue-Light", size: 17.75)!,
                                                        .foregroundColor : UIColor("#00adf1")])
            attr.append(attr2)
            return EmptyPageView.Template.text
                .set(attributed: attr)
                .change(hspace: .text, value: 20)
                .mix()
                .set(tap: backgroundTapEvent())
        case .slack:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_slack"))
                .set(title: "You don't have any recent mentions",
                     color: UIColor("#d7d7d7"),
                     font: UIFont.systemFont(ofSize: 19))
                .change(hspace: .text, value: 20)
                .mix()
                .set(tap: backgroundTapEvent())
        case .tumblr:
            return EmptyPageView.Template.standard
                .set(image: UIImage(named: "placeholder_tumblr"))
                .set(title: "This is your Dashboard.",
                     color: UIColor("#aab6c4"),
                     font: UIFont.systemFont(ofSize: 18))
                .set(text: "When you follow some blogs, their latest posts will show up here!",
                     color: UIColor("#828e9c"),
                     font: UIFont.systemFont(ofSize: 17))
                .change(hspace: .text, value: 20)
                .change(vspace: .imageWithTitle, value: 10)
                .change(vspace: .titleWithText, value: 10)
                .mix()
                .set(backgroundColor: UIColor("#34465c"))
                .set(tap: backgroundTapEvent())
        }
    }
    
    var item: Item {
        switch self {
        case .px500:         return Item(title: "500px", subtitle: "500px", image: UIImage(named: "icon_500px")!)
        case .airbnb:        return Item(title: "Airbnb", subtitle: "Airbnb, Inc.", image: UIImage(named: "icon_airbnb")!)
        case .appStore:      return Item(title: "AppStore", subtitle: "Apple, Inc.", image: UIImage(named: "icon_appstore")!)
        case .camera:        return Item(title: "Camera", subtitle: "Apple, Inc.", image: UIImage(named: "icon_camera")!)
        case .dropbox:       return Item(title: "Dropbox", subtitle: "Dropbox, Inc.", image: UIImage(named: "icon_dropbox")!)
        case .fackbook:      return Item(title: "Facebook", subtitle: "Facebook, Inc.", image: UIImage(named: "icon_facebook")!)
        case .fancy:         return Item(title: "Fancy", subtitle: "Thing Daemon, Inc.", image: UIImage(named: "icon_fancy")!)
        case .foursquare:    return Item(title: "Foursquare", subtitle: "Foursquare Labs", image: UIImage(named: "icon_foursquare")!)
        case .icloud:        return Item(title: "iCloud", subtitle: "Apple, Inc.", image: UIImage(named: "icon_icloud")!)
        case .instagram:     return Item(title: "Instagram", subtitle: "Instagram, Inc.", image: UIImage(named: "icon_instagram")!)
        case .itunesConnect: return Item(title: "iTunes Connect", subtitle: "Apple, Inc.", image: UIImage(named: "icon_itunes_connect")!)
        case .kickstarter:   return Item(title: "Kickstarter", subtitle: "Kickstarter, Inc.", image: UIImage(named: "icon_kickstarter")!)
        case .path:          return Item(title: "Path", subtitle: "Path, Inc.", image: UIImage(named: "icon_path")!)
        case .photo:         return Item(title: "Photos", subtitle: "Apple, Inc.", image: UIImage(named: "icon_photos")!)
        case .podcasts:      return Item(title: "Podcasts", subtitle: "Apple, Inc.", image: UIImage(named: "icon_podcasts")!)
        case .remote:        return Item(title: "Remote", subtitle: "Apple, Inc.", image: UIImage(named: "icon_remote")!)
        case .safari:        return Item(title: "Safari", subtitle: "Apple, Inc.", image: UIImage(named: "icon_safari")!)
        case .skype:         return Item(title: "Skype", subtitle: "Skype Communications S.a.r.l", image: UIImage(named: "icon_skype")!)
        case .slack:         return Item(title: "Slack", subtitle: "Tiny Speck, Inc.", image: UIImage(named: "icon_slack")!)
        case .tumblr:        return Item(title: "Tumblr", subtitle: "Tumblr, Inc.", image: UIImage(named: "icon_tumblr")!)
        }
    }
    
    
}
