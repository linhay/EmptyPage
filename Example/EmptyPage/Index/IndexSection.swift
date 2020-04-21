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

class IndexSection: SectionCollectionProtocol {
    var core: SectionCore?
    var index: Int = 0
    var itemCount: Int { models.count }
    var collectionView: UICollectionView?

    func config(sectionView: UICollectionView) {
        sectionView.st.register(IndexCell.self)
    }

    let models: [IndexModel]

    init(models: [IndexModel]) {
        self.models = models
    }

    func itemSize(at index: Int) -> CGSize {
        return IndexCell.preferredSize(collectionView: collectionView, model: nil)
    }

    func item(at index: Int) -> UICollectionViewCell {
        let cell = collectionView.st.dequeueCell(indexPath(from: index)) as IndexCell
        if let model = models.value(at: index) {
            cell.config(model)
        }
        return cell
    }

    func didSelectItem(at index: Int) {
        models.value(at: index)?.delegate.call()
    }

}
