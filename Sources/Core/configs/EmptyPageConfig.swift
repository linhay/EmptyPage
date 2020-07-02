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
