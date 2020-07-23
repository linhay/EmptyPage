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
import EmptyPage

enum Standard: String, CaseIterable {
    case image
    case text
    case standard

    func view() -> EmptyPageView {
        switch self {
        case .image:
            return EmptyPageView.Template.image
                .set(image: UIImage(named: "empty"))
                .mix()
        case .text:
            return EmptyPageView.Template.text
                .set(text: "搜索不到数据")
                .mix()
        case .standard:
            return EmptyPageView.Template.standard
                .config(imageView: {
                    $0.set(image: UIImage(named: "empty"))
                })
                .config(textLabel: { $0.text = "搜索不到数据" })
                .config(button: {
                    $0.setTitle("点击重试", for: .normal)
                    $0.set {
                        print("tap event")
                    }
                })
                .mix()
        }
    }
}

class IndexStandardSection: SectionCollectionProtocol {

    var core: SectionCore?

    var itemCount: Int = Standard.allCases.count

    func config(sectionView: UICollectionView) {
        sectionView.st.register(IndexTextCell.self)
        sectionView.st.register(IndexHeaderView.self, for: .header)
    }

    var headerSize: CGSize {
        return IndexHeaderView.preferredSize(collectionView: sectionView, model: nil)
    }

    var headerView: UICollectionReusableView? {
        let view = dequeue(kind: .header) as IndexHeaderView
        view.config("Standard")
        view.tapEvent.delegate(on: self) { (self, _) in
            self.itemCount = self.itemCount == 1 ? Standard.allCases.count : 1
            self.reload()
        }
        return view
    }

    func itemSize(at row: Int) -> CGSize {
        return IndexTextCell.preferredSize(collectionView: sectionView, model: nil)
    }

    func item(at row: Int) -> UICollectionViewCell {
        let cell: IndexTextCell = dequeue(at: row)
        if let style = Standard.allCases.value(at: row) {
            cell.config(title: style.rawValue, text: "")
        }
        return cell
    }

    func didSelectItem(at row: Int) {
        guard let item = Standard.allCases.value(at: row) else {
            return
        }

        let vc = UITableViewController()
        vc.tableView.backgroundColor = .white
        vc.view.backgroundColor = .white
        vc.tableView.separatorStyle = .none
        vc.tableView.ep.set(emptyView: item.view())
        sectionView.st.viewController?.st.push(vc: vc)
    }

}
