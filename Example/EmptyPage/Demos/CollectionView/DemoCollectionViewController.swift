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

class DemoCollectionViewController: UIViewController {

    @IBOutlet weak var sectionView: SectionCollectionView!
    lazy var manager = SectionCollectionManager(sectionView: sectionView)

    var section = DemoCollectionSection()

    var emptyView: UIView {
        EmptyStore.demo.standard(tapEvent: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.sectionView.ep.setEmpty(EmptyStore.loading, isReload: true)
            self.refresh()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionView.ep.setEmpty(EmptyStore.loading, isReload: true)
        sectionView.ep.reload()
//        sectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
//        self.sectionView.mj_header?.beginRefreshing()
    }

    @objc
    func refresh() {
        Gcd.delay(2) { [weak self] in
            guard let self = self else {
                return
            }
            self.sectionView.ep.setEmpty(self.emptyView)
            self.section.insert(at: 0)
            self.sectionView.mj_header?.endRefreshing()
            self.manager.update(self.section)
        }
    }

    @IBAction func deleteItemsAction(_ sender: UIButton) {
        section.delete(at: 0)
    }

    @IBAction func insertItemsAction(_ sender: UIButton) {
        section.insert(at: 0)
    }

    @IBAction func deleteSectionsAction(_ sender: UIButton) {
        manager.delete(at: 0)
    }

    @IBAction func insertSectionsAction(_ sender: UIButton) {
        manager.insert(section: DemoCollectionSection(), at: 0)
    }
}
