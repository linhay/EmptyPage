//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

open class EmptyPageTableViewManager: EmptyPageScrollViewManager {
    
    public var tableView: UITableView? { target as? UITableView }
    
    open override func isEmpty() -> Bool {
        guard let tableView = tableView else {
            return false
        }
        
        let count = tableView.dataSource?.numberOfSections?(in: tableView) ?? tableView.numberOfSections
        return (0..<count).contains(where: { tableView.numberOfRows(inSection: $0) > 0 }) == false
    }
    
}
