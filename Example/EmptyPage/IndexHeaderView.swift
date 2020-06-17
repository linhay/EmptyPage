//
//  IndexHeaderView.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stuart
import Stem

class IndexHeaderView: UICollectionReusableView, STNibProtocol, ConfigurableCollectionCell {

    static func preferredSize(collectionView: UICollectionView, model: String?) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 60)
    }

    @IBOutlet private weak var titleLabel: UILabel!

    func config(_ model: String) {
        titleLabel.text = model
    }

}
