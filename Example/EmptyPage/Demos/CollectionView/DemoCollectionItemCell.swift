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

class DemoCollectionItemCell: UICollectionViewCell, ConfigurableCollectionCell, STViewProtocol {

    static func preferredSize(collectionView: UICollectionView, model: Void?) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

}
