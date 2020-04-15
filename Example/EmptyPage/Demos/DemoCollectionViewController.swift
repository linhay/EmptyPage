//
//  DemoCollectionViewController.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import SVProgressHUD
import MJRefresh
import Stem
import Stuart

class DemoCollectionItemCell: SectionItemCell<Void>,STViewProtocol {

    override class func preferredSize(collectionView: UICollectionView, model: Void? = nil) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }

}

class DemoCollectionSection: SectionProtocol {
    var index: Int = 0

   unowned var collectionView: UICollectionView

    var itemCount: Int = 3

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.st.register(DemoCollectionItemCell.self)
    }

    func itemSize(at index: Int) -> CGSize {
        DemoCollectionItemCell.preferredSize(collectionView: collectionView)
    }

    func itemCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.st.dequeueCell(indexPath) as DemoCollectionItemCell
        cell.backgroundColor = UIColor.st.random
        return cell
    }


}

class DemoCollectionViewController: SectionController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "示例",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(jumpToMain))
        sectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
        sectionView.ep.setEmpty(EmptyStore.demo.standard(tapEvent: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.refresh()
        }))
        refresh()
    }

    @objc
    func jumpToMain() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    func refresh() {
        if sectionView.mj_header?.isRefreshing == false {
            sectionView.mj_header?.beginRefreshing()
            return
        }
        Gcd.delay(2) { [weak self] in
            guard let self = self else {
                return
            }
            self.manager.update(sections: self.manager.sections.isEmpty ? [DemoCollectionSection(collectionView: self.sectionView)] : [])
            self.sectionView.mj_header?.endRefreshing()
        }
    }

}
