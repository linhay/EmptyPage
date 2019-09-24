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

    var itemHeights: [CGFloat] { get }
    var headerHeight: CGFloat { get }
    var footerHeight: CGFloat { get }

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    var headerView: UITableViewHeaderFooterView? { get }
    var footerView: UITableViewHeaderFooterView? { get }

}


extension SectionTableType {

    var tableView: UITableView { return sectionController.tableView }
    var headerView: UITableViewHeaderFooterView? { return nil }
    var footerView: UITableViewHeaderFooterView? { return nil }

    var itemHeights: [CGFloat] {
        return [CGFloat](repeating: UITableView.automaticDimension, count: itemCount)
    }

    var headerHeight: CGFloat {
        return UITableView.automaticDimension
    }

    var footerHeight: CGFloat {
        if footerView == nil {
            return 0.01
        }else {
            return UITableView.automaticDimension
        }
    }


    func didSelectItem(at index: Int) { }

    func refresh() {
        UIView.performWithoutAnimation {
            tableView.reloadSections(IndexSet(arrayLiteral: index), with: .none)
        }
    }

}
