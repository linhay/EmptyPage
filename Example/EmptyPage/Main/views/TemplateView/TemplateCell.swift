//
//  TemplateCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class TemplateCell: UITableViewCell, STNibProtocol {
    
    @IBOutlet private weak var titleLabel: UILabel!
}

extension TemplateCell {

    func config(title: String?) {
        titleLabel.text = title
    }

}
