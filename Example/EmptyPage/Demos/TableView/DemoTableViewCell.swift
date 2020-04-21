//
//  DemoTableViewCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stuart
import Stem

class DemoTableViewCell: SectionTableItemCell<Void>, STNibProtocol {

    override class var preferredHeight: CGFloat {
        return 44
    }
    
}
