//
//  TestMJRefreshCollectionVC.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/8/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import EmptyPage
import MJRefresh

class TestMJRefreshCollectionVC: SectionCollectionViewController {

    func config(canScroll: Bool) {
        sectionView.ep.canScrollEnabled = canScroll
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sectionView.ep.setEmpty(TemplateSet.standard1(tapEvent: nil))
        
        sectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Gcd.delay(.main, seconds: 2) { [weak self] in
                guard let self = self else {
                    return
                }
                self.sectionView.mj_header?.endRefreshing()
                self.manager.reload()
            }
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sectionView.ep.manager?.resize()
    }

}
