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
    
}
