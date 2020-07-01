//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

public extension EmptyPage where Base: UITableView {
    
    var manager: EmptyPageTableViewManager? {
        if base.useCustomManager {
            return base.emptyPageViewManager as? EmptyPageTableViewManager
        }
        
        if base.emptyPageViewManager == nil {
            if let placeholder = EmptyPageConfig.shared.tableViewGloalManager?(base) {
                set(manager: placeholder)
            } else {
                set(manager: EmptyPageTableViewManager(delegate: base))
            }
        }
        
        return base.emptyPageViewManager as? EmptyPageTableViewManager
    }
    
    func set(emptyView view: UIView?) {
        EmptyPageRuntime.swizzingLayout
        EmptyPageRuntime.swizzingTableView
        if let view = view {
            manager?.set(emptyView: { view })
        } else {
            manager?.set(emptyView: nil)
        }
    }
    
}
