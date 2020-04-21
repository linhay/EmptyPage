//
//  DemoTableSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Stem
import Stuart

class DemoTableSection: SectionTableProtocol {

    var core: SectionCore?
    var itemCount: Int { list.count }
    var list: [Int] = .init(repeating: 0, count: 3)

    func itemHeight(at index: Int) -> CGFloat {
        return DemoTableViewCell.preferredHeight
    }

    func config(sectionView: UITableView) {
        sectionView.st.register(DemoTableViewCell.self)
    }

    func item(at index: Int) -> UITableViewCell {
        let cell: DemoTableViewCell = tableView.st.dequeueCell(indexPath(from: index))
        cell.contentView.backgroundColor = UIColor.st.random
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
