//
//  DemoTableHeaderView.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import Stuart

class DemoTableHeaderView: UITableViewHeaderFooterView, ConfigurableTableCell {

    static func preferredHeight(model: Void?) -> CGFloat {
        return 44
    }

}
