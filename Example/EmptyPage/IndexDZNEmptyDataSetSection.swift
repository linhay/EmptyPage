//
//  IndexStandardSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stuart
import Stem

class IndexDZNEmptyDataSetSection: SectionCollectionProtocol {

    var core: SectionCore?

    var itemCount: Int = DZNEmptyDataSet.allCases.count

    func config(sectionView: UICollectionView) {
        sectionView.st.register(IndexCell.self)
        sectionView.st.register(IndexHeaderView.self, for: .header)
    }

    var headerSize: CGSize {
        return IndexHeaderView.preferredSize(collectionView: collectionView, model: nil)
    }

    var headerView: UICollectionReusableView? {
        let view = dequeue(kind: .header) as IndexHeaderView
        view.config("DZNEmptyDataSet")
        view.tapEvent.delegate(on: self) { (self, _) in
            self.itemCount = self.itemCount == 1 ? DZNEmptyDataSet.allCases.count : 1
            self.reload()
        }
        return view
    }

    func itemSize(at row: Int) -> CGSize {
        return IndexCell.preferredSize(collectionView: collectionView, model: nil)
    }

    func item(at row: Int) -> UICollectionViewCell {
        let cell: IndexCell = dequeue(at: row)
        if let style = DZNEmptyDataSet.allCases.value(at: row)?.item {
            cell.config(icon: style.image, title: style.title, text: style.subtitle)
        }
        return cell
    }

    func didSelectItem(at row: Int) {
        guard let item = DZNEmptyDataSet.allCases.value(at: row) else {
            return
        }

        let vc = UITableViewController()
        vc.tableView.backgroundColor = .white
        vc.view.backgroundColor = .white
        vc.tableView.separatorStyle = .none
        vc.tableView.ep.setEmpty(item.view())
        sectionView?.st.viewController?.st.push(vc: vc)
    }

}
