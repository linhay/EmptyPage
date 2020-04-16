//
//  DemoCollectionItemCell.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Stem
import Stuart

class DemoCollectionItemCell: SectionItemCell<Void>,STViewProtocol {

    override class func preferredSize(collectionView: UICollectionView, model: Void? = nil) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

}
