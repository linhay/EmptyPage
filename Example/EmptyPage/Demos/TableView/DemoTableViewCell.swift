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

class DemoTableViewCell: UITableViewCell, ConfigurableTableCell, STNibProtocol {

    static func preferredSize(tableView: UITableView, model: Void?) -> CGSize {
        .init(width: 0, height: 44)
    }
    
}
