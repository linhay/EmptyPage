//
//  IndexTextCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import Stuart

class IndexTextCell: UICollectionViewCell, ConfigurableCollectionCell, STNibProtocol {

    static func preferredSize(collectionView: UICollectionView, model: Void?) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 60)
    }

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!

    func config(title: String, text: String) {
        titleLabel.isHidden = title.isEmpty
        textLabel.isHidden = text.isEmpty
        titleLabel.text = title
        textLabel.text = text
    }


}
