//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

open class EmptyPageCollectionViewManager: EmptyPageScrollViewManager {

    public var collectionView: UICollectionView? { target as? UICollectionView }

    open override func isEmpty() -> Bool {
        guard let collectionView = collectionView else {
            return false
        }

        let count = collectionView.dataSource?.numberOfSections?(in: collectionView) ?? collectionView.numberOfSections
        return (0..<count).contains(where: { collectionView.numberOfItems(inSection: $0) > 0 }) == false
    }

}
