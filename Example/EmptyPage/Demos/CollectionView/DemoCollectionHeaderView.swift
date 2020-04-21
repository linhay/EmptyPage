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

class DemoCollectionHeaderView: UICollectionReusableView, ConfigurableCollectionCell, STNibProtocol {

     class func preferredSize(collectionView: UICollectionView, model: Void?) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 44)
    }

}
