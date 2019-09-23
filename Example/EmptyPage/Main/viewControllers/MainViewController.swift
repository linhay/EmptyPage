//
//  MainViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/9/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class MainViewController: SectionTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.update(sections: [ActionSection(self),
                               EmptyViewSection(self)])
    }

}
