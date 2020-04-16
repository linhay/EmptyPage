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

class IndexCell: STSectionItemCell<Void>, STNibProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override class func preferredSize(collectionView: UICollectionView, model: Void? = nil) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 45)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(model: IndexModel)  {
        titleLabel.text = model.title
    }

}
