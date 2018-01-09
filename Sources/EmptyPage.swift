//
//  EmptyPage.swift
//  EmptyPage
//
//  Created by bigl on 2018/1/9.
//

import UIKit

public struct EmptyPage {
  
  private static var isRun = false
  
  public static func begin() {
    if isRun { return }
    isRun = true
    RunTime.exchangeMethod(selector: #selector(UITableView.reloadData),
                           replace: #selector(UITableView.table_emptyReloadData),
                           class: UITableView.self)
    RunTime.exchangeMethod(selector: #selector(UICollectionView.reloadData),
                           replace: #selector(UICollectionView.coll_emptyReloadData),
                           class: UICollectionView.self)
  }
  
}
