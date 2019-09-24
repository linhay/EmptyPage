//
//  TemplateSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class TemplateSection: SectionTableType {

    var index: Int = 0

    var sectionController: SectionTableViewController

    var itemCount: Int = 3

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.st.dequeueCell(indexPath) as TemplateCell
        switch indexPath.item {
        case 0: cell.config(title: "纯文字")
        case 1: cell.config(title: "纯图片")
        case 2: cell.config(title: "标准")
        default: break
        }
        return cell
    }

    init(_ sectionController: SectionTableViewController) {
        self.sectionController = sectionController
        tableView.st.register(TemplateCell.self)
    }

    var headerView: UITableViewHeaderFooterView? {
        let view = tableView.st.dequeueHeaderFooterView() as MainHeaderView
        view.config(title: "Template 示例") { [weak self] in
            guard let self = self else { return }
            self.itemCount = self.itemCount > 0 ? 0 : 3
            self.refresh()
        }
        return view
    }

    func didSelectItem(at index: Int) {
        let vc = UITableViewController()
        vc.tableView.separatorStyle = .none
        switch index {
        case 0: vc.tableView.ep.setEmpty(EmptyViewStore.template.text)
        case 1: vc.tableView.ep.setEmpty(EmptyViewStore.template.image)
        case 2: vc.tableView.ep.setEmpty(EmptyViewStore.template.standard)
        default: break
        }
        sectionController.st.push(vc: vc)
    }
    
}
