//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

public extension EmptyPage where Base: UIView {

    var manager: EmptyPageViewManager? {
        if base.useCustomManager {
            return base.emptyPageViewManager
        }

        if base.emptyPageViewManager == nil, let placeholder = EmptyPageConfig.shared.viewGloalManager {
            set(manager: placeholder)
        }

        return base.emptyPageViewManager
    }

    func set(manager: EmptyPageViewManager?) {
        base.useCustomManager = true
        base.emptyPageViewManager = manager
    }

    func reload() {
        manager?.reload()
    }

    func set(emptyView view: UIView?) {
        EmptyPageRuntime.swizzingLayout
        if let view = view {
            manager?.set(emptyView: { view }, in: base)
        } else {
            manager?.set(emptyView: nil, in: base)
        }
    }

}

public extension EmptyPage where Base: UIView {

    var emptyView: UIView? { manager?.emptyView }

    var isShow: Bool { manager?.isShow ?? false }

}
