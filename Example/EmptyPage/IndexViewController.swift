//
//  IndexViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class IndexViewController: SectionCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.update(StandardSection(),
                       DemoSection(),
                       DribbbleSection(),
                       DZNEmptyDataSetSection())
    }

}
