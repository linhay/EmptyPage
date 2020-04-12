//
//  AppDelegate.swift
//  EmptyPage
//
//  Created by is.linhay@outlook.com on 01/09/2018.
//  Copyright (c) 2018 is.linhay@outlook.com. All rights reserved.
//

import UIKit
import EmptyPage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: IndexViewController())
    window?.makeKeyAndVisible()
    return true
  }

}

