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

    /// UIView 的全局 EmptyPageViewManager
    public private(set) var viewGloalManager: EmptyPageViewManager?
    /// UIScrollView 的全局 EmptyPageScrollViewManager
    public private(set) var scrollViewGloalManager: EmptyPageScrollViewManager?
    /// UITableView 的全局 EmptyPageTableViewManager
    public private(set) var tableViewGloalManager: EmptyPageTableViewManager?
    /// UICollectionView 的全局 EmptyPageCollectionViewManager
    public private(set) var collectionViewGloalManager: EmptyPageCollectionViewManager?

}

public extension EmptyPageConfig {

    /// 设置 UIView 的全局 EmptyPageViewManager
    /// - Parameter provider: EmptyPageViewManager
    func setGloalManager(view provider: EmptyPageViewManager?) {
        viewGloalManager = provider
    }

    /// 设置 UIScrollView 的全局 EmptyPageScrollViewManager
    /// - Parameter provider: EmptyPageScrollViewManager
    func setGloalManager(scrollView provider: EmptyPageScrollViewManager?) {
        scrollViewGloalManager = provider
    }

    /// 设置 UITableView 的全局 EmptyPageTableViewManager
    /// - Parameter provider: EmptyPageTableViewManager
    func setGloalManager(tableView provider: EmptyPageTableViewManager?) {
        tableViewGloalManager = provider
    }

    /// 设置 UICollectionView 的全局 EmptyPageCollectionViewManager
    /// - Parameter provider: EmptyPageCollectionViewManager
    func setGloalManager(collectionView provider: EmptyPageCollectionViewManager?) {
        collectionViewGloalManager = provider
    }

}
