//
//  ToolbarCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import Stuart

class ToolbarCell: UICollectionViewCell, STNibProtocol, ConfigurableCollectionCell {



    static func preferredSize(collectionView: UICollectionView, model: String?) -> CGSize {
        return .init(width: 100, height: 60)
    }

    @IBOutlet weak var textLabel: UILabel!

    func config(_ model: String) {
        config(model, isSelect: false, canSelect: true)
    }

    func config(_ model: String, isSelect: Bool, canSelect: Bool) {
        textLabel.text = model
        switch (isSelect, canSelect) {
        case (true, true):
            textLabel.textColor = UIColor(0x999999)
        case (false, true):
            textLabel.textColor = UIColor(0x333333)
        case (false, false):
            textLabel.textColor = UIColor(0x999999)
        default:
            textLabel.textColor = UIColor(0x999999)

        }
    }
}
