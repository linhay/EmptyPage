//
//  EmptyPage+UIView.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

public extension EmptyPage where Base: UICollectionView {

    var manager: EmptyPageCollectionViewManager? {
        if base.useCustomManager {
            return base.emptyPageViewManager as? EmptyPageCollectionViewManager
        }

        if base.emptyPageViewManager == nil {
            if let placeholder = EmptyPageConfig.shared.collectionViewGloalManager {
                set(manager: placeholder)
            } else {
                set(manager: EmptyPageCollectionViewManager())
            }
        }

        return base.emptyPageViewManager as? EmptyPageCollectionViewManager
    }

    func set(emptyView view: UIView?) {
        EmptyPageRuntime.swizzingLayout
        EmptyPageRuntime.swizzingCollectionView
        if let view = view {
            manager?.set(emptyView: { view }, in: base)
        } else {
            manager?.set(emptyView: nil, in: base)
        }
    }

}
