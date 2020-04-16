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

    @IBOutlet weak var sectionView: SectionView!
    lazy var manager = SectionManager(sectionView: sectionView)

    var section = DemoCollectionSection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func refresh() {
        if sectionView.mj_header?.isRefreshing == false {
            sectionView.mj_header?.beginRefreshing()
            return
        }
        Gcd.delay(2) { [weak self] in
            guard let self = self else {
                return
            }
            self.manager.update(self.section)
            self.sectionView.mj_header?.endRefreshing()
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
