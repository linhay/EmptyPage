//
//  TestStateViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/9/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import MJRefresh
import EmptyPage

class TestStateViewController: UIViewController {

    @IBOutlet weak var sectionView: SectionCollectionView!
    lazy var manager = SectionCollectionManager(sectionView: sectionView)
    var token: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        sectionView.ex.set(emptyView: TemplateSet.image_animate().mix(), for: .loading)
        sectionView.ex.set(emptyView: TemplateSet.image_normal().mix(), for: .normal)
        sectionView.ex.set(emptyView: TemplateSet.standard1(tapEvent: nil).mix(), for: .noNetwork)

        sectionView.ex.set(canScroll: false, for: .loading)
        sectionView.ex.set(canScroll: true, for: .normal)
        sectionView.ex.set(canScroll: false, for: .noNetwork)

        token = sectionView.observe(\.bounds, options: [.new, .old]) { (_, _) in
            print(self.sectionView.frame)
        }

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

    @IBAction func setNoNetwork(_ sender: UIButton) {
        sectionView.ex.change(state: .noNetwork)
        manager.reload()
    }

    @IBAction func setNormal(_ sender: UIButton) {
        sectionView.ex.change(state: .normal)
        manager.reload()
    }

    @IBAction func setLoading(_ sender: UIButton) {
        sectionView.ex.change(state: .loading)
        manager.reload()
    }
}
