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

class IndexSection: STSectionProtocol {


    var index: Int = 0
    var itemCount: Int { models.count }
    var collectionView: UICollectionView?

    func config(collectionView: UICollectionView) {
        collectionView.st.register(IndexCell.self)
    }
    let models: [IndexModel]

    init(models: [IndexModel]) {
        self.models = models
    }

    func itemSize(at index: Int) -> CGSize {
        return IndexCell.preferredSize(collectionView: sectionView)
    }

    func itemCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sectionView.st.dequeueCell(indexPath) as IndexCell
        if let model = models.value(at: indexPath.item) {
            cell.config(model: model)
        }
        return cell
    }

    func didSelectItem(at indexPath: IndexPath) {
        models.value(at: indexPath.item)?.delegate.call()
    }

}
