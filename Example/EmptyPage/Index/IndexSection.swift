//
//  IndexSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stuart
import Stem

class IndexSection: SectionProtocol {

    var index: Int = 0

    unowned var collectionView: UICollectionView

    var itemCount: Int { models.count }

    let models: [IndexModel]

    init(collectionView: UICollectionView, models: [IndexModel]) {
        self.collectionView = collectionView
        self.models = models
        collectionView.st.register(IndexCell.self)
    }

    func itemSize(at index: Int) -> CGSize {
        return IndexCell.preferredSize(collectionView: collectionView)
    }

    func itemCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.st.dequeueCell(indexPath) as IndexCell
        if let model = models.value(at: indexPath.item) {
            cell.config(model: model)
        }
        return cell
    }

    func didSelectItem(at indexPath: IndexPath) {
        models.value(at: indexPath.item)?.delegate.call()
    }

}
