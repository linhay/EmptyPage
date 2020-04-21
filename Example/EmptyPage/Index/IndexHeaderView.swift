//
//  IndexHeaderViewCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import Stuart

class IndexHeaderView: UICollectionViewCell, STNibProtocol, ConfigurableCollectionCell {

    static func preferredSize(collectionView: UICollectionView, model: String?) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.st.random
    }

    func config(_ model: String) {
        textLabel.text = model
    }

}
