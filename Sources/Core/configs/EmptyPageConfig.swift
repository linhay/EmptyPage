//
//  EmptyPageConfig.swift
//  EmptyPage
//
//  Created by 林翰 on 2020/6/29.
//

import UIKit

public final class EmptyPageConfig {

    public static let shared = EmptyPageConfig()

    private init() {}

    public private(set) var viewGloalManager: ((_: UIView) -> EmptyPageViewManager)?
    public private(set) var scrollViewGloalManager: ((_: UIScrollView) -> EmptyPageScrollViewManager)?
    public private(set) var tableViewGloalManager: ((_: UITableView) -> EmptyPageTableViewManager)?
    public private(set) var collectionViewGloalManager: ((UICollectionView) -> EmptyPageCollectionViewManager)?

}

public extension EmptyPageConfig {

    func setGloalManager(view provider: ((_: UIView) -> EmptyPageViewManager)?) {
        viewGloalManager = provider
    }

    func setGloalManager(scrollView provider: ((_: UIScrollView) -> EmptyPageScrollViewManager)?) {
        scrollViewGloalManager = provider
    }

    func setGloalManager(tableView provider: ((_: UITableView) -> EmptyPageTableViewManager)?) {
        tableViewGloalManager = provider
    }

    func setGloalManager(collectionView provider: ((UICollectionView) -> EmptyPageCollectionViewManager)?) {
        collectionViewGloalManager = provider
    }

}
