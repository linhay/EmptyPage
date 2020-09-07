//
//  TestStateViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/9/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class TestStateViewController: UIViewController {

    @IBOutlet weak var sectionView: SectionCollectionView!
    lazy var manager = SectionCollectionManager(sectionView: sectionView)
    var token: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        sectionView.ep.set(emptyView: TemplateSet.image_animate().mix(), for: .loading)
        sectionView.ep.set(emptyView: TemplateSet.image_normal().mix(), for: .normal)
        sectionView.ep.set(emptyView: TemplateSet.standard1(tapEvent: nil).mix(), for: .noNetwork)
        token = sectionView.observe(\.bounds, options: [.new, .old]) { (_, _) in
            print(self.sectionView.frame)
        }
    }


    @IBAction func setNoNetwork(_ sender: UIButton) {
        sectionView.ep.change(state: .noNetwork)
        manager.reload()
    }
    @IBAction func setNormal(_ sender: UIButton) {
        sectionView.ep.change(state: .normal)
        manager.reload()
    }

    @IBAction func setLoading(_ sender: UIButton) {
        sectionView.ep.change(state: .loading)
        manager.reload()
    }
}
