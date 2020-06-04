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

class DemoCollectionSection: SectionCollectionProtocol {

    var core: SectionCore?
    var itemCount: Int { list.count }

    var list: [Int] = .init(repeating: 0, count: 3)

    func config(sectionView: UICollectionView) {
        sectionView.st.register(DemoCollectionHeaderView.self, for: .header)
        sectionView.st.register(DemoCollectionItemCell.self)
    }


    var headerSize: CGSize {
        return DemoCollectionHeaderView.preferredSize(collectionView: collectionView, model: nil)
    }

    var headerView: UICollectionReusableView? {
        let view: DemoCollectionHeaderView = collectionView.st.dequeue(at: indexPath(from: 0), kind: .header)
        return view
    }

    func config(sectionView: UITableView) {
        sectionView.st.register(DemoTableViewCell.self)
    }

    func itemSize(at index: Int) -> CGSize {
        DemoCollectionItemCell.preferredSize(collectionView: collectionView, model: nil)
    }

    func item(at index: Int) -> UICollectionViewCell {
        let cell = collectionView.st.dequeue(at: indexPath(from: index)) as DemoCollectionItemCell
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
