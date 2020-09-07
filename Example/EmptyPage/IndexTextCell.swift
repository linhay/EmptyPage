//
//  IndexTextCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem

protocol IndexTextCellModelProtocol {
    var title: String { get }
    var text: String { get }
}

class IndexTextCell: UICollectionViewCell, ConfigurableView, STNibProtocol {

    static func preferredSize(limit size: CGSize, model: IndexTextCellModelProtocol?) -> CGSize {
        return .init(width: size.width, height: 60)
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!

    func config(_ model: IndexTextCellModelProtocol) {
        titleLabel.isHidden = model.title.isEmpty
        textLabel.isHidden = model.text.isEmpty
        titleLabel.text = model.title
        textLabel.text = model.text
    }


}
