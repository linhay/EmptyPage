//
//  EmptyPage
//
//  Copyright (c) 2018 linhay - https://github.com/linhay
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

public struct EmptyPage {
  
  fileprivate static var tableViewLock = false
  
  /// 替换 tableView 相关函数
  static func swizzingTableView() {
    if tableViewLock { return }
    tableViewLock = true
    replaceMethod(selector: #selector(UITableView.layoutSubviews),
                  with: #selector(UITableView.table_emptyLayoutSubviews),
                  class: UITableView.self)
    
    replaceMethod(selector: #selector(UITableView.layoutIfNeeded),
                  with: #selector(UITableView.table_emptyLayoutIfNeeded),
                  class: UITableView.self)
    
    replaceMethod(selector: #selector(UITableView.insertRows(at:with:)),
                  with: #selector(UITableView.table_emptyInsertRows(at:with:)),
                  class: UITableView.self)
    
    replaceMethod(selector: #selector(UITableView.deleteRows(at:with:)),
                  with: #selector(UITableView.table_emptyDeleteRows(at:with:)),
                  class: UITableView.self)
    
    replaceMethod(selector: #selector(UITableView.insertSections(_:with:)),
                  with: #selector(UITableView.table_emptyInsertSections(_:with:)),
                  class: UITableView.self)
    
    replaceMethod(selector: #selector(UITableView.deleteSections(_:with:)),
                  with: #selector(UITableView.table_emptyDeleteSections(_:with:)),
                  class: UITableView.self)
    
    replaceMethod(selector: #selector(UITableView.reloadData),
                  with: #selector(UITableView.table_emptyReloadData),
                  class: UITableView.self)
  }
  
  
  fileprivate static var collectionViewLock = false
  
  /// 替换 CollectionView 相关函数
  static func swizzingCollectionView() {
    if collectionViewLock { return }
    collectionViewLock = true
    replaceMethod(selector: #selector(UICollectionView.layoutSubviews),
                  with: #selector(UICollectionView.coll_emptyLayoutSubviews),
                  class: UICollectionView.self)
    
    replaceMethod(selector: #selector(UICollectionView.layoutIfNeeded),
                  with: #selector(UICollectionView.coll_emptyLayoutIfNeeded),
                  class: UICollectionView.self)
    
    replaceMethod(selector: #selector(UICollectionView.reloadData),
                  with: #selector(UICollectionView.coll_emptyReloadData),
                  class: UICollectionView.self)
    
    replaceMethod(selector: #selector(UICollectionView.insertItems(at:)),
                  with: #selector(UICollectionView.coll_emptyInsertItems(at:)),
                  class: UICollectionView.self)
    
    replaceMethod(selector: #selector(UICollectionView.deleteItems(at:)),
                  with: #selector(UICollectionView.coll_emptyDeleteItems(at:)),
                  class: UICollectionView.self)
    
    replaceMethod(selector: #selector(UICollectionView.insertSections(_:)),
                  with: #selector(UICollectionView.coll_emptyInsertSections(_:)),
                  class: UICollectionView.self)
    
    replaceMethod(selector: #selector(UICollectionView.deleteSections(_:)),
                  with: #selector(UICollectionView.coll_emptyDeleteSections(_:)),
                  class: UICollectionView.self)
  }
  
  /// 交换方法
  ///
  /// - Parameters:
  ///   - selector: 被交换的方法
  ///   - replace: 用于交换的方法
  ///   - classType: 所属类型
  static func replaceMethod(selector: Selector,with: Selector,class classType: AnyClass) {
    let select1 = selector
    let select2 = with
    
    guard let select1Method = class_getInstanceMethod(classType, select1) else {
      assertionFailure("can't find method: " + select1.description)
      return
    }
    
    guard let select2Method = class_getInstanceMethod(classType, select2) else {
      assertionFailure("can't find method: " + select1.description)
      return
    }
    
    let didAddMethod  = class_addMethod(classType,
                                        select1,
                                        method_getImplementation(select2Method),
                                        method_getTypeEncoding(select2Method))
    if didAddMethod {
      class_replaceMethod(classType,
                          select2,
                          method_getImplementation(select1Method),
                          method_getTypeEncoding(select1Method))
    }else {
      method_exchangeImplementations(select1Method, select2Method)
    }
  }
}
