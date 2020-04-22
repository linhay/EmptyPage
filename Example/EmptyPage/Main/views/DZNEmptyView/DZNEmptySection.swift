//
//  DZNEmptySection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SVProgressHUD
import EmptyPage

class DZNEmptySection: SectionTableType {

    var index: Int = 0

    unowned var sectionController: SectionTableViewController

    var itemCount: Int = DZEmptyStyle.allCases.count

    var itemHeights: [CGFloat] {
        return [CGFloat](repeating: 60, count: itemCount)
    }

    var headerView: UITableViewHeaderFooterView? {
        let view = tableView.st.dequeue() as MainHeaderView
        view.config(title: "DZNEmptyDataSet 示例") { [weak self] in
            guard let self = self else { return }
            self.itemCount = self.itemCount > 0 ? 0 : DZEmptyStyle.allCases.count
            self.refresh()
        }
        return view
    }

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.st.dequeue(at: indexPath) as TemplateCell
        let style = DZEmptyStyle.allCases[indexPath.item]
        cell.config(title: style.item.title)
        return cell
    }

    init(_ sectionController: SectionTableViewController) {
        self.sectionController = sectionController
        tableView.st.register(DZNEmptyCell.self)
    }

    func didSelectItem(at index: Int) {
        let style = DZEmptyStyle.allCases[index]
        let vc = UITableViewController()
        vc.tableView.separatorStyle = .none
        vc.tableView.ep.setEmpty(style)
        sectionController.st.push(vc: vc)
    }
}
