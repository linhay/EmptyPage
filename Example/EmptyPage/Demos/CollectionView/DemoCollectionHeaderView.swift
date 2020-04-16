//
//  DemoCollectionHeaderView.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import Stuart

class DemoCollectionHeaderView: STSectionReusableView<Void>, STNibProtocol {

    override class func preferredSize(collectionView: UICollectionView, model: Void?) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: 44)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
