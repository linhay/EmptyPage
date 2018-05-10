//
//  EmptyPage.swift
//  EmptyPage
//
//  Created by linhey on 2018/1/10.
//  Copyright © 2018年 linhey <linhan.linhey@outlook.com>. All rights reserved.

import UIKit

public struct EmptyPage {
  
  fileprivate static var tableViewLock = false
  
  /// 替换 tableView 相关函数
  static func swizzingTableView() {
    if tableViewLock { return }
    tableViewLock = true
    exchangeMethod(selector: #selector(UITableView.layoutSubviews),
                   replace: #selector(UITableView.table_emptyLayoutSubviews),
                   class: UITableView.self)
    
    exchangeMethod(selector: #selector(UITableView.layoutIfNeeded),
                   replace: #selector(UITableView.table_emptyLayoutIfNeeded),
                   class: UITableView.self)
    
    exchangeMethod(selector: #selector(UITableView.insertRows(at:with:)),
                   replace: #selector(UITableView.table_emptyInsertRows(at:with:)),
                   class: UITableView.self)
    
    exchangeMethod(selector: #selector(UITableView.deleteRows(at:with:)),
                   replace: #selector(UITableView.table_emptyDeleteRows(at:with:)),
                   class: UITableView.self)
    
    exchangeMethod(selector: #selector(UITableView.insertSections(_:with:)),
                   replace: #selector(UITableView.table_emptyInsertSections(_:with:)),
                   class: UITableView.self)
    
    exchangeMethod(selector: #selector(UITableView.deleteSections(_:with:)),
                   replace: #selector(UITableView.table_emptyDeleteSections(_:with:)),
                   class: UITableView.self)
    
    exchangeMethod(selector: #selector(UITableView.reloadData),
                   replace: #selector(UITableView.table_emptyReloadData),
                   class: UITableView.self)
  }
  
  
  fileprivate static var collectionViewLock = false
  
  /// 替换 CollectionView 相关函数
  static func swizzingCollectionView() {
    if collectionViewLock { return }
    collectionViewLock = true
    exchangeMethod(selector: #selector(UICollectionView.layoutSubviews),
                   replace: #selector(UICollectionView.coll_emptyLayoutSubviews),
                   class: UICollectionView.self)
    
    exchangeMethod(selector: #selector(UICollectionView.layoutIfNeeded),
                   replace: #selector(UICollectionView.coll_emptyLayoutIfNeeded),
                   class: UICollectionView.self)
    
    exchangeMethod(selector: #selector(UICollectionView.reloadData),
                   replace: #selector(UICollectionView.coll_emptyReloadData),
                   class: UICollectionView.self)
    
    exchangeMethod(selector: #selector(UICollectionView.insertItems(at:)),
                   replace: #selector(UICollectionView.coll_emptyInsertItems(at:)),
                   class: UICollectionView.self)
    
    exchangeMethod(selector: #selector(UICollectionView.deleteItems(at:)),
                   replace: #selector(UICollectionView.coll_emptyDeleteItems(at:)),
                   class: UICollectionView.self)
    
    exchangeMethod(selector: #selector(UICollectionView.insertSections(_:)),
                   replace: #selector(UICollectionView.coll_emptyInsertSections(_:)),
                   class: UICollectionView.self)
    
    exchangeMethod(selector: #selector(UICollectionView.deleteSections(_:)),
                   replace: #selector(UICollectionView.coll_emptyDeleteSections(_:)),
                   class: UICollectionView.self)
  }
  
  /// 交换方法
  ///
  /// - Parameters:
  ///   - selector: 被交换的方法
  ///   - replace: 用于交换的方法
  ///   - classType: 所属类型
  static func exchangeMethod(selector: Selector,
                             replace: Selector,
                             class classType: AnyClass) {
    let select1 = selector
    let select2 = replace
    let select1Method = class_getInstanceMethod(classType, select1)
    let select2Method = class_getInstanceMethod(classType, select2)
    let didAddMethod  = class_addMethod(classType,
                                        select1,
                                        method_getImplementation(select2Method!),
                                        method_getTypeEncoding(select2Method!))
    if didAddMethod {
      class_replaceMethod(classType,
                          select2,
                          method_getImplementation(select1Method!),
                          method_getTypeEncoding(select1Method!))
    }else {
      method_exchangeImplementations(select1Method!, select2Method!)
    }
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
