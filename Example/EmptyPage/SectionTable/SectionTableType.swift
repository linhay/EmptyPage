//
//  SectionTableType.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol SectionTableType {

    var index: Int { set get }
    var sectionController: SectionTableViewController { get }
    var tableView: UITableView { get }
    var itemCount: Int { get }
    func didSelectItem(at index: Int)

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    var headerView: UITableViewHeaderFooterView? { get }
    var footerView: UITableViewHeaderFooterView? { get }

}


extension SectionTableType {

    var tableView: UITableView { return sectionController.tableView }
    var headerView: UITableViewHeaderFooterView? { return nil }
    var footerView: UITableViewHeaderFooterView? { return nil }
    func didSelectItem(at index: Int) { }

    func refresh() {
        UIView.performWithoutAnimation {
            tableView.reloadSections(IndexSet(arrayLiteral: index), with: .none)
        }
    }

}
