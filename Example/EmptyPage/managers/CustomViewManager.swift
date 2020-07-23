//
//  CustomViewManager.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/7/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

class CustomViewManager: EmptyPageViewManager {

    override func isEmpty() -> Bool {
       return target?.subviews.isEmpty ?? false
    }

}
