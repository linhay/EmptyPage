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
    var title: String = ""

    func config(sectionView: UICollectionView) {
        sectionView.st.register(IndexCell.self)
        sectionView.st.register(IndexHeaderView.self, for: .header)
    }

    let models: [IndexModel]

    init(models: [IndexModel]) {
        self.models = models
    }

    var headerSize: CGSize {
        return IndexHeaderView.preferredSize(collectionView: collectionView, model: nil)
    }

    var headerView: UICollectionReusableView? {
        guard title.isEmpty == false else {
            return nil
        }
        let header: IndexHeaderView = collectionView.st.dequeue(at: indexPath(from: index), kind: .header)
        header.config(title)
        return header
    }

    func itemSize(at index: Int) -> CGSize {
        return IndexCell.preferredSize(collectionView: collectionView, model: nil)
    }

    func item(at index: Int) -> UICollectionViewCell {
        let cell = collectionView.st.dequeue(at: indexPath(from: index)) as IndexCell
        if let model = models.value(at: index) {
            cell.config(model)
        }
        return cell
    }

    func didSelectItem(at index: Int) {
        models.value(at: index)?.delegate.call()
    }

}
