//
//  EmptyViewSectionCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class EmptyViewSectionCell: UITableViewCell, STNibProtocol {

    @IBOutlet private weak var sourceBtn: UIButton!{
        didSet{
            sourceBtn.layer.cornerRadius =  sourceBtn.bounds.width * 0.5
            sourceBtn.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    
}

extension EmptyViewSectionCell {

    func config(title: String, url: String? = nil) {
        titleLabel.text = title
        sourceBtn.isHidden = url == nil
    }
}
