//
//  IndexStandardSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import Stem
import SnapKit

class DZNEmptyDataSetSection: BaseSection {

    override var title: String { "DZNEmptyDataSet" }

    override var rawModels: [IndexTextCell.Model] { DZNEmptyDataSet.allCases }

    override func didSelectItem(at row: Int) {
        guard let item = DZNEmptyDataSet.allCases.value(at: row) else {
            return
        }

        let vc = UITableViewController()
        vc.tableView.backgroundColor = .white
        vc.view.backgroundColor = .white
        vc.tableView.separatorStyle = .none
        vc.tableView.ep.set(emptyView: item.view())
        sectionView.st.viewController?.st.push(vc)
    }

}

enum DZNEmptyDataSet: String, CaseIterable, IndexTextCellModelProtocol {
    case px500
    case airbnb
    case appStore
    case camera
    case dropbox
    case facebook
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

    var title: String { rawValue }
    var text: String { rawValue }

    func view() -> EmptyPageView {
        switch self {
        case .px500:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_500px")) })
                .config(titleLabel: {
                    $0.set(text: "No Photos",
                           color: UIColor("#545454"),
                           font: UIFont.boldSystemFont(ofSize: 17))
                })
                .config(textLabel: {
                    $0.set(text: "Get started by uploading a photo.",
                           color: UIColor("#545454"),
                           font: UIFont.boldSystemFont(ofSize: 15))
                })
                .layout(view: .titleLabel, types: .afterSpac(15))
                .mix()
                .set(backgroundColor: UIColor.black)
        case .airbnb:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_airbnb")) })
                .config(titleLabel: {
                    $0.set(text: "No Messages",
                           color: UIColor("#c9c9c9"),
                           font: UIFont(name: "HelveticaNeue-Light", size: 22)!)
                })
                .config(textLabel: {
                    $0.set(text: "When you have messages, you’ll see them here.",
                           color: UIColor("#cfcfcf"),
                           font: UIFont.boldSystemFont(ofSize: 13))
                })
                .config(button: { (item) in
                    item.setTitle("Start Browsing", for: .normal)
                    item.setTitleColor(UIColor("#6bceff"), for: .normal)
                    item.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    item.backgroundColor = UIColor.white
                })
                .layout(type: .afterSpac(24), views: .imageView, .titleLabel, .textLabel)
                .mix()
        case .appStore:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_appstore")) })
                .config(textLabel: {
                    $0.set(text: "There are no results for “wwdc2014”.",
                           color: UIColor("#333333"),
                           font: UIFont.boldSystemFont(ofSize: 14))
                })
                .config(button: { (item) in
                    item.setTitle("Start Browsing", for: .normal)
                    item.setTitleColor(UIColor("#6bceff"), for: .normal)
                    item.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    item.backgroundColor = UIColor.white
                })
                .layout(view: .imageView, types: .height(44), .width(44), .afterSpac(34))
                .mix()
        case .camera:
            return EmptyPageView.Template.standard
                .config(titleLabel: {
                    $0.set(text: "Please Allow Photo Access",
                           color: UIColor("#5f6978"),
                           font: UIFont.boldSystemFont(ofSize: 18))
                })
                .config(textLabel: {
                    $0.set(text: "This allows you to share photos from your library and save photos to your camera roll.",
                           color: UIColor("#5f6978"),
                           font: UIFont.systemFont(ofSize: 14))
                })
                .config(button: {
                    $0.setTitle("Continue", for: .normal)
                })
                .mix()
        case .dropbox:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_dropbox")) })
                .config(titleLabel: {
                    $0.set(text: "Star Your Favorite Files",
                           color: UIColor("#25282b"),
                           font: UIFont.boldSystemFont(ofSize: 17))
                })
                .config(textLabel: {
                    $0.set(text: "Favorites are saved for offline access.",
                           color: UIColor("#7b8994"),
                           font: UIFont.systemFont(ofSize: 14.5))
                })
                .config(button: {
                    $0.setTitle("Learn more", for: .normal)
                    $0.setTitleColor(UIColor("#48a1ea"), for: .normal)
                })
                .mix()
                .set(backgroundColor: UIColor("#f0f3f5"))
        case .facebook:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_facebook")) })
                .config(titleLabel: {
                    $0.set(text: "No friends to show.",
                           color: UIColor("#acafbd"),
                           font: UIFont.boldSystemFont(ofSize: 22))
                })
                .layout(view: .imageView, types: .afterSpac(30))
                .mix()
                .set(backgroundColor: UIColor("#eceef7"))
        case .fancy:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_fancy")) })
                .config(titleLabel: {
                    $0.set(text: "No Owns yet",
                           color: UIColor("#494c53"),
                           font: UIFont.boldSystemFont(ofSize: 14))
                })
                .config(textLabel: {
                    $0.set(text: "Tap Add to List and add things to Owns",
                           color: UIColor("#7a7d83"),
                           font: UIFont.boldSystemFont(ofSize: 13))
                })
                .mix()
                .set(backgroundColor: UIColor("#f0f0f0"))
        case .foursquare:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_foursquare")) })
                .config(textLabel: {
                    $0.set(text: "Nobody has liked or commented on your check-ins yet.",
                           color: UIColor("#cecbc6"),
                           font: UIFont.systemFont(ofSize: 14))
                })
                .config(button: {
                    $0.setTitle("Add friends to get started!", for: .normal)
                    $0.setTitleColor(UIColor("#00aeef"), for: .normal)
                    $0.layer.cornerRadius = 18
                    $0.layer.borderColor = $0.titleColor(for: .normal)!.cgColor
                    $0.layer.borderWidth = 1
                    $0.layer.masksToBounds = true
                })
                .layout(view: .button, types: .height(36))
                .layout(view: .textLabel, types: .insets(16))
                .layout(view: .textLabel, types: .afterSpac(16))
                .layout(view: .imageView, types: .afterSpac(16))
                .mix()
                .set(backgroundColor: UIColor("#fcfcfa"))
        case .icloud:
            return EmptyPageView.Template.standard
                .config(titleLabel: {
                    $0.set(text: "iCloud Photo Sharing",
                           color: UIColor("#999999"),
                           font: UIFont.systemFont(ofSize: 30))
                })
                .config(textLabel: {
                    $0.set(text: "Share photos and videos with just the people you choose, and let them add photos, videos, and comments.",
                           color: UIColor("#999999"),
                           font: UIFont.systemFont(ofSize: 18))
                })
                .config(button: { (item) in
                    item.setTitle("Create New Stream", for: .normal)
                    item.setTitleColor(UIColor("#999999"), for: .normal)
                    item.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    item.layer.cornerRadius = 2
                    item.layer.borderColor = item.titleColor(for: .normal)!.cgColor
                    item.layer.borderWidth = 1
                    item.layer.masksToBounds = true
                })
                .layout(view: .button, types: .insets(100))
                .layout(view: .textLabel, types: .insets(40))
                .layout(view: .titleLabel, types: .afterSpac(16))
                .layout(view: .textLabel, types: .afterSpac(20))
                .mix()
        case .instagram:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_instagram")) })
                .config(titleLabel: {
                    $0.set(text: "Instagram Direct",
                           color: UIColor("#444444"),
                           font: UIFont(name: "HelveticaNeue-Light", size: 26)!)
                })
                .config(textLabel: {
                    $0.set(text: "Send photos and videos directly to your friends. Only the people you send to can see these posts.",
                           color: UIColor("#444444"),
                           font: UIFont.systemFont(ofSize: 16))
                })
                .layout(view: .imageView, types: .afterSpac(24))
                .layout(view: .titleLabel, types: .afterSpac(24))
                .layout(view: .textLabel, types: .insets(20))
                .layout(view: .titleLabel, types: .insets(20))
                .mix()
        case .itunesConnect:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_itunes_connect")) })
                .config(titleLabel: {
                    $0.set(text: "No Favorites",
                           color: UIColor.lightGray,
                           font: UIFont.systemFont(ofSize: 22))
                })
                .config(textLabel: {
                    $0.set(text: "To add a favorite, tap the star icon next to an App's name.",
                           color: UIColor.lightGray,
                           font: UIFont.systemFont(ofSize: 14))
                })
                .layout(view: .imageView, types: .afterSpac(9))
                .layout(view: .titleLabel, types: .afterSpac(9))
                .layout(view: .textLabel, types: .insets(40))
                .layout(view: .titleLabel, types: .insets(40))
                .mix()
        case .kickstarter:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_kickstarter")) })
                .config(titleLabel: {
                    $0.set(text: "Activity empty",
                           color: UIColor("#828587"),
                           font: UIFont.systemFont(ofSize: 16))
                })
                .config(textLabel: {
                    $0.set(text: "When you back a project or follow a friend, their activity will show up here.",
                           color: UIColor("#828587"),
                           font: UIFont.systemFont(ofSize: 14))
                })
                .config(button: {
                    $0.setTitle("Discover projects", for: .normal)
                    $0.setTitleColor(UIColor.white, for: .normal)
                    $0.backgroundColor = UIColor.gray
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    $0.layer.cornerRadius = 2
                    $0.layer.masksToBounds = true
                })
                .layout(view: .imageView, types: .afterSpac(15))
                .layout(view: .titleLabel, types: .afterSpac(15))
                .layout(view: .textLabel, types: .insets(40))
                .layout(view: .titleLabel, types: .insets(40))
                .layout(view: .button, types: .height(45))
                .layout(view: .button, types: .insets(40))
                .mix()
                .set(backgroundColor: UIColor("#f7fafa"))
        case .path:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_path")) })
                .config(titleLabel: {
                    $0.set(text: "Message Your Friends",
                           color: UIColor.white,
                           font: UIFont.boldSystemFont(ofSize: 16))
                })
                .config(textLabel: {
                    $0.set(text: "Send a message or create a group.",
                           color: UIColor("#a6978d"),
                           font: UIFont.systemFont(ofSize: 14))
                })
                .layout(view: .imageView, types: .afterSpac(1))
                .layout(view: .titleLabel, types: .afterSpac(1))
                .mix()
                .set(backgroundColor: UIColor("#726d67"))
        case .photo:
            return EmptyPageView.Template.standard
                .config(titleLabel: {
                    $0.set(text: "No Photos or Videos",
                           color: UIColor("#999999"),
                           font: UIFont.systemFont(ofSize: 30))
                })
                .config(textLabel: {
                    $0.set(text: "You can sync photos and videos onto your iPhone using iTunes.",
                           color: UIColor("#999999"),
                           font: UIFont.systemFont(ofSize: 18))
                })
                .layout(view: .textLabel, types: .insets(40))
                .layout(view: .titleLabel, types: .afterSpac(15))
                .mix()
        case .podcasts:
            return EmptyPageView.Template.standard
                .config(titleLabel: {
                    $0.set(text: "No Podcasts",
                           color: UIColor("#999999"),
                           font: UIFont.systemFont(ofSize: 30))
                })
                .config(textLabel: {
                    $0.set(text: "You can subscribe to podcasts in Top Charts or Featured.",
                           color: UIColor("#999999"),
                           font: UIFont.systemFont(ofSize: 18))
                })
                .layout(view: .textLabel, types: .insets(35))
                .layout(view: .titleLabel, types: .afterSpac(45))
                .mix()
        case .remote:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_remote")) })
                .config(titleLabel: {
                    $0.set(text: "Cannot Connect to a Local Network",
                           color: UIColor("#555555"),
                           font: UIFont(name: "HelveticaNeue-Medium", size: 18)!)
                })
                .config(textLabel: {
                    $0.set(text: "You must connect to a Wi-Fi network to control iTunes or Apple TV",
                           color: UIColor("#555555"),
                           font: UIFont(name: "HelveticaNeue-Medium", size: 11.75)!)
                })
                .layout(view: .textLabel, types: .insets(20))
                .mix()
        case .safari:
            return EmptyPageView.Template.text
                .set(text: "Safari cannot open the page because your iPhone is not connected to the Internet.",
                     color: UIColor("#7d7f7f"),
                     font: UIFont.systemFont(ofSize: 18))
                .mix()
                .layout(horizontal: .leftSpacer(20), .rightSpacer(20))
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
                .mix()
                .layout(horizontal: .leftSpacer(20), .rightSpacer(20))
        case .slack:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_slack")) })
                .config(textLabel: {
                    $0.set(text: "You don't have any recent mentions",
                           color: UIColor("#d7d7d7"),
                           font: UIFont.systemFont(ofSize: 19))
                })
                .layout(view: .textLabel, types: .insets(20))
                .mix()
        case .tumblr:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "placeholder_tumblr")) })
                .config(titleLabel: {
                    $0.set(text: "This is your Dashboard.",
                           color: UIColor("#aab6c4"),
                           font: UIFont.systemFont(ofSize: 18))
                })
                .config(textLabel: {
                    $0.set(text: "When you follow some blogs, their latest posts will show up here!",
                           color: UIColor("#828e9c"),
                           font: UIFont.systemFont(ofSize: 17))
                })
                .layout(view: .textLabel, types: .insets(20))
                .layout(view: .imageView, types: .afterSpac(10))
                .layout(view: .titleLabel, types: .afterSpac(10))
                .mix()
                .set(backgroundColor: UIColor("#34465c"))
        }

    }

    var item: (title: String, subtitle: String, image: UIImage) {
        switch self {
        case .px500:         return (title: "500px", subtitle: "500px", image: UIImage(named: "icon_500px")!)
        case .airbnb:        return (title: "Airbnb", subtitle: "Airbnb, Inc.", image: UIImage(named: "icon_airbnb")!)
        case .appStore:      return (title: "AppStore", subtitle: "Apple, Inc.", image: UIImage(named: "icon_appstore")!)
        case .camera:        return (title: "Camera", subtitle: "Apple, Inc.", image: UIImage(named: "icon_camera")!)
        case .dropbox:       return (title: "Dropbox", subtitle: "Dropbox, Inc.", image: UIImage(named: "icon_dropbox")!)
        case .facebook:      return (title: "Facebook", subtitle: "Facebook, Inc.", image: UIImage(named: "icon_facebook")!)
        case .fancy:         return (title: "Fancy", subtitle: "Thing Daemon, Inc.", image: UIImage(named: "icon_fancy")!)
        case .foursquare:    return (title: "Foursquare", subtitle: "Foursquare Labs", image: UIImage(named: "icon_foursquare")!)
        case .icloud:        return (title: "Instagram", subtitle: "Instagram, Inc.", image: UIImage(named: "icon_instagram")!)
        case .itunesConnect: return (title: "iTunes Connect", subtitle: "Apple, Inc.", image: UIImage(named: "icon_itunes_connect")!)
        case .kickstarter:   return (title: "Kickstarter", subtitle: "Kickstarter, Inc.", image: UIImage(named: "icon_kickstarter")!)
        case .path:          return (title: "Path", subtitle: "Path, Inc.", image: UIImage(named: "icon_path")!)
        case .photo:         return (title: "Photos", subtitle: "Apple, Inc.", image: UIImage(named: "icon_photos")!)
        case .podcasts:      return (title: "Podcasts", subtitle: "Apple, Inc.", image: UIImage(named: "icon_podcasts")!)
        case .remote:        return (title: "Remote", subtitle: "Apple, Inc.", image: UIImage(named: "icon_remote")!)
        case .safari:        return (title: "Safari", subtitle: "Apple, Inc.", image: UIImage(named: "icon_safari")!)
        case .skype:         return (title: "Skype", subtitle: "Skype Communications S.a.r.l", image: UIImage(named: "icon_skype")!)
        case .slack:         return (title: "Slack", subtitle: "Tiny Speck, Inc.", image: UIImage(named: "icon_slack")!)
        case .tumblr:        return (title: "Tumblr", subtitle: "Tumblr, Inc.", image: UIImage(named: "icon_tumblr")!)
        case .instagram:     return (title: "Tumblr", subtitle: "Tumblr, Inc.", image: UIImage(named: "icon_tumblr")!)
        }
    }
}

