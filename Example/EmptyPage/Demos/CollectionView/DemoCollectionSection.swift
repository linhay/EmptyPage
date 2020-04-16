//
//  DemoCollectionSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Stem
import Stuart

class DemoCollectionSection: STSectionProtocol {

    var collectionView: UICollectionView?
    var index: Int = 0
    var itemCount: Int {
        return list.count
    }

    var list: [Int] = .init(repeating: 0, count: 3)


    func config(collectionView: UICollectionView) {
        collectionView.st.registerSupplementaryView(kind: .header, DemoCollectionHeaderView.self)
        collectionView.st.register(DemoCollectionItemCell.self)
    }

    var headerSize: CGSize {
        DemoCollectionHeaderView.preferredSize(collectionView: sectionView, model: nil)
    }

    func headerView(at indexPath: IndexPath) -> UICollectionReusableView? {
        let view: DemoCollectionHeaderView = sectionView.st.dequeueSupplementaryView(kind: .header, indexPath: indexPath)
        return view
    }

    func itemSize(at index: Int) -> CGSize {
        DemoCollectionItemCell.preferredSize(collectionView: sectionView)
    }

    func itemCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sectionView.st.dequeueCell(indexPath) as DemoCollectionItemCell
        cell.backgroundColor = UIColor.st.random
        return cell
    }


    func delete(at index: Int, willUpdate: (() -> Void)? = nil) {
        guard list.isEmpty == false else {
            return
        }
        delete(at: [index]) { [weak self] in
            guard let self = self else {
                return
            }
            self.list.remove(at: index)
        }
    }

    func insert(at index: Int, willUpdate: (() -> Void)? = nil) {
        insert(at: [0]) { [weak self] in
            guard let self = self else {
                return
            }
            self.list.insert(0, at: 0)
        }
    }

}
