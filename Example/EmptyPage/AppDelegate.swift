//
//  AppDelegate.swift
//  EmptyPage
//
//  Created by is.linhay@outlook.com on 01/09/2018.
//  Copyright (c) 2018 is.linhay@outlook.com. All rights reserved.
//

import UIKit
import EmptyPage
import Reachability

class AppManager {
    
    static let shared = AppManager()
    
    let reachability = try! Reachability()
    
    func start() {
        startReachability()
    }
    
    func startReachability() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationItem.st.isHideBackButtonText = true
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        
        AppManager.shared.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: IndexViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    
    
}

