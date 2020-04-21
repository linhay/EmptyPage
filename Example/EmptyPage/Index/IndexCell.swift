//
//  IndexCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stuart
import Stem

class IndexCell: UICollectionViewCell, ConfigurableCollectionCell, STNibProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    
    static func preferredSize(collectionView: UICollectionView, model: IndexModel?) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 45)
    }

    func config(_ model: IndexModel) {
        titleLabel.text = model.title
    }

}
