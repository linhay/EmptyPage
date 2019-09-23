//
//  ActionSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class ActionSection: SectionTableType {

    var index: Int = 0

    unowned var sectionController: SectionTableViewController

    var itemCount: Int = 1

    var headerView: UITableViewHeaderFooterView? {
        let view = tableView.st.dequeueHeaderFooterView() as MainHeaderView
        view.config(title: "Action 示例") { [weak self] in
            guard let self = self else { return }
            self.itemCount = self.itemCount > 0 ? 0 : 1
            self.refresh()
        }
        return view
    }

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.st.dequeueCell(indexPath) as ActionCell
            cell.configLeft(title: "执行: 全局添加 EmptyView") { (_) in

            }

            cell.configRight(title: "取消: 全局添加 EmptyView") { (_) in
                
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }

    init(_ sectionController: SectionTableViewController) {
        self.sectionController = sectionController
        tableView.st.register(ActionCell.self)
        tableView.st.registerHeaderFooterView(MainHeaderView.self)
    }

}
