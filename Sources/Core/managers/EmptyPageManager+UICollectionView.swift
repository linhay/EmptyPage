//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

open class EmptyPageCollectionViewManager: EmptyPageScrollViewManager {

    public convenience init(delegate: UICollectionView) {
        self.init(delegate: delegate) { [weak delegate] () -> Bool in
            guard let collectionView = delegate else {
                return false
            }

            let count = collectionView.dataSource?.numberOfSections?(in: collectionView) ?? collectionView.numberOfSections
            return (0..<count).contains(where: { collectionView.numberOfItems(inSection: $0) > 0 }) == false
        }
    }

}
