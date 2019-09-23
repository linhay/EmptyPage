//
//  EmptyViewSection.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/9/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
import Stem

class EmptyViewSection: SectionTableType {

    var index: Int = 0
    unowned var sectionController: SectionTableViewController
    var itemCount: Int = 2

    init(_ sectionController: SectionTableViewController) {
        self.sectionController = sectionController
        tableView.st.register(EmptyViewSectionCell.self)
        tableView.st.registerHeaderFooterView(MainHeaderView.self)
    }

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.st.dequeueCell(indexPath) as EmptyViewSectionCell
        switch indexPath.item {
        case 0: cell.config(title: "TableView 示例")
        case 1: cell.config(title: "CollectionView 示例")
        default: break
        }
        return cell
    }

    var headerView: UITableViewHeaderFooterView? {
        let view = tableView.st.dequeueHeaderFooterView() as MainHeaderView
        view.config(title: "EmptyPage 示例") { [weak self] in
            guard let self = self else { return }
            self.itemCount = self.itemCount > 0 ? 0 : 2
            self.refresh()
        }
        return view
    }

    func didSelectItem(at index: Int) {
        let vc = HomeViewController()
        sectionController.st.push(vc: vc)
    }

}
