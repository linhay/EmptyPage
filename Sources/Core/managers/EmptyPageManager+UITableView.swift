//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

open class EmptyPageTableViewManager: EmptyPageScrollViewManager {

    public convenience init(delegate: UITableView) {
        self.init(delegate: delegate) { [weak delegate] () -> Bool in
            guard let tableView = delegate else {
                return false
            }

            let count = tableView.dataSource?.numberOfSections?(in: tableView) ?? tableView.numberOfSections
            return (0..<count).contains(where: { tableView.numberOfRows(inSection: $0) > 0 }) == false
        }
    }

}
