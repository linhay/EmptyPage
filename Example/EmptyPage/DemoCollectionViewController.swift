//
//  DemoCollectionViewController.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DemoCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

  var rows = 0


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(collectionView)
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 100)
    layout.scrollDirection = .vertical
    collectionView.backgroundColor = UIColor.gray
    collectionView.frame = view.bounds
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = layout
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    getData()
  }


  func getData() {
    collectionView.setEmpty(view: EmptyStore.loading)
    collectionView.reloadData()
    rows = 0
    sleep(3) {[weak self] in
      guard let base = self else { return }
      base.collectionView.emptyView = EmptyStore.custom(block1: {[weak self] in
        guard let base = self else { return }
        base.getData()
      }) {[weak self] in
        guard let base = self else { return }
        base.rows = 2
        base.collectionView.insertItems(at: [IndexPath(row: 0, section: 0),
                                             IndexPath(row: 1, section: 0)])
      }
      base.collectionView.reloadData()
    }
  }


  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }


  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return rows
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    rows -= 1
    collectionView.deleteItems(at: [indexPath])
  }

}
