//
//  EmptyPage.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public struct EmptyPage {
  
  private static var isRun = false
  
  public static func begin() {
    if isRun { return }
    isRun = true

    RunTime.exchangeMethod(selector: #selector(UITableView.layoutSubviews),
                           replace: #selector(UITableView.table_emptyLayoutSubviews),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.layoutIfNeeded),
                           replace: #selector(UITableView.table_emptyLayoutIfNeeded),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.insertRows(at:with:)),
                           replace: #selector(UITableView.table_emptyInsertRows(at:with:)),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.deleteRows(at:with:)),
                           replace: #selector(UITableView.table_emptyDeleteRows(at:with:)),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.insertSections(_:with:)),
                           replace: #selector(UITableView.table_emptyInsertSections(_:with:)),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.deleteSections(_:with:)),
                           replace: #selector(UITableView.table_emptyDeleteSections(_:with:)),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.reloadData),
                           replace: #selector(UITableView.table_emptyReloadData),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.layoutSubviews),
                           replace: #selector(UICollectionView.coll_emptyLayoutSubviews),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.layoutIfNeeded),
                           replace: #selector(UICollectionView.coll_emptyLayoutIfNeeded),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.reloadData),
                           replace: #selector(UICollectionView.coll_emptyReloadData),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.insertItems(at:)),
                           replace: #selector(UICollectionView.coll_emptyInsertItems(at:)),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.deleteItems(at:)),
                           replace: #selector(UICollectionView.coll_emptyDeleteItems(at:)),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.insertSections(_:)),
                           replace: #selector(UICollectionView.coll_emptyInsertSections(_:)),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.deleteSections(_:)),
                           replace: #selector(UICollectionView.coll_emptyDeleteSections(_:)),
                           class: UICollectionView.self)
  }
}


extension NSLayoutConstraint {

  /// 修改倍率
  ///
  /// - Parameter multiplier: 新倍率
  /// - Returns: Constraint
  func change(multiplier: CGFloat) -> NSLayoutConstraint {
    NSLayoutConstraint.deactivate([self])

    let newConstraint = NSLayoutConstraint(
      item: firstItem as Any,
      attribute: firstAttribute,
      relatedBy: relation,
      toItem: secondItem,
      attribute: secondAttribute,
      multiplier: multiplier,
      constant: constant)

    newConstraint.priority = priority
    newConstraint.shouldBeArchived = self.shouldBeArchived
    newConstraint.identifier = self.identifier

    NSLayoutConstraint.activate([newConstraint])
    return newConstraint
  }

}
