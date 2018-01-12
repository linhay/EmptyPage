//
//  AppDelegate.swift
//  EmptyPage
//
//  Created by linhan.linhey@outlook.com on 01/09/2018.
//  Copyright (c) 2018 linhan.linhey@outlook.com. All rights reserved.
//

import UIKit
import EmptyPage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    EmptyPage.begin()
    window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
    window?.makeKeyAndVisible()
    return true
  }

}

