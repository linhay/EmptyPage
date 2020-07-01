//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

public extension EmptyPage where Base: UIScrollView {
    
    var manager: EmptyPageScrollViewManager? {
        if base.useCustomManager {
            return base.emptyPageViewManager as? EmptyPageScrollViewManager
        }
        
        if base.emptyPageViewManager == nil, let placeholder = EmptyPageConfig.shared.scrollViewGloalManager?(base) {
            set(manager: placeholder)
        }
        
        return base.emptyPageViewManager as? EmptyPageScrollViewManager
    }
    
    var canScrollEnabled: Bool {
        set { manager?.canScrollEnabled = newValue }
        get { manager?.canScrollEnabled ?? false }
    }
    
}
