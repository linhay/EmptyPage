//
//  EmptyPage
//
//  Copyright (c) 2018 linhey - https://github.com/linhay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

import UIKit

open class EmptyPageTableViewManager: EmptyPageScrollViewManager {

    /// 被设置空白页的 View
    public var tableView: UITableView? { target as? UITableView }
    
    /// 判断数据源是否为空
    /// - Returns: 数据源是否为空结果
    open override func isEmpty() -> Bool {
        guard let view = tableView else {
            return false
        }
        
        if let dataSource = view.dataSource, let count = view.dataSource?.numberOfSections?(in: view), count > 0 {
            return (0..<count).contains(where: { dataSource.tableView(view, numberOfRowsInSection: $0) > 0 || hasHeaderOrFooter(in: $0 )}) == false
        } else if view.numberOfSections > 0 {
            return (0..<view.numberOfSections).contains(where: { view.numberOfRows(inSection: $0) > 0 || hasHeaderOrFooter(in: $0) }) == false
        }
        
        return true
    }
    
}

private extension EmptyPageTableViewManager {
    
    func hasHeaderOrFooter(in section: Int) -> Bool {
        guard let view = tableView else {
            return false
        }
        
        guard let delegate = view.delegate else {
            return false
        }
        
        if delegate.tableView?(view, viewForHeaderInSection: section) != nil,
           (delegate.tableView?(view, heightForHeaderInSection: section) ?? view.sectionHeaderHeight) > 0 {
            return true
        }
        
        if delegate.tableView?(view, viewForFooterInSection: section) != nil,
           (delegate.tableView?(view, heightForFooterInSection: section) ?? view.sectionFooterHeight) > 0 {
            return true
        }
        
        return false
    }
    
}
