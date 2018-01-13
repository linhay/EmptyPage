//
//  EmptyPage.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public struct EmptyPage {
  
  private static var isRun = false
  
  public static func begin() {
    if isRun { return }
    isRun = true
    RunTime.exchangeMethod(selector: #selector(UITableView.reloadData),
                           replace: #selector(UITableView.table_emptyReloadData),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UITableView.layoutSubviews),
                           replace: #selector(UITableView.empty_layoutSubviews),
                           class: UITableView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.layoutSubviews),
                           replace: #selector(UICollectionView.empty_layoutSubviews),
                           class: UICollectionView.self)

    RunTime.exchangeMethod(selector: #selector(UICollectionView.reloadData),
                           replace: #selector(UICollectionView.coll_emptyReloadData),
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
