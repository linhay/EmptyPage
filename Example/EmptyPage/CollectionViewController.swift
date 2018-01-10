//
//  CollectionViewController.swift
//  EmptyPage_Example
//
//  Created by bigl on 2018/1/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
  
  var count = 0 {
    didSet{
      collectionView?.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
    self.collectionView!.register(UICollectionViewCell.self,
                                  forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  
  
  func getData() {
    collectionView?.emptyView = EmptyView.loading()
    collectionView?.reloadData()
    /// 延时5s模拟网络请求
    let time = DispatchTime.now() + .milliseconds(Int(5 * 1000))
    DispatchQueue.global().asyncAfter(deadline: time) {
      DispatchQueue.main.async { [weak self] in
        guard let base = self else { return }
        base.collectionView?.emptyView = EmptyView.noData(block1: {
          base.count = 50
        }){
          base.getData()
        }
        base.collectionView?.reloadData()
      }
    }
  }
  
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    cell.contentView.backgroundColor = .red
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    count = 0
  }
  
}
