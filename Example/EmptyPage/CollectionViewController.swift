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

    let emptyView = EmptyView.initFromNib
    emptyView.delegate = self
    collectionView?.emptyView = emptyView

    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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

extension CollectionViewController: EmptyViewDelegate {

  func emptyView(view: EmptyView, tapEvent: UIButton) {
count = 20
  }

}
