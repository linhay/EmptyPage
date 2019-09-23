//
//  SectionTableCell.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SectionTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
