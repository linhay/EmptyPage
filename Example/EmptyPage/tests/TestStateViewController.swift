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
    @IBOutlet var stateButtons: [UIButton]!
    
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
        
        sectionView.ep.setEmpty(TemplateSet.standard1(tapEvent: nil))
        
        stateButtons[0].addTarget(self, action: #selector(setLoading(_:)), for: .touchUpInside)
        stateButtons[1].addTarget(self, action: #selector(setNormal(_:)), for: .touchUpInside)
        stateButtons[2].addTarget(self, action: #selector(setNoNetwork(_:)), for: .touchUpInside)
        
        setNormal(stateButtons[1])
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sectionView.mj_header?.beginRefreshing()
    }
    
    @objc
    func setNoNetwork(_ sender: UIButton) {
        stateButtons.forEach({ $0.backgroundColor = self.view.backgroundColor })
        sender.backgroundColor = UIColor.lightGray
        sectionView.ex.change(state: .noNetwork)
    }
    
    @objc
    func setNormal(_ sender: UIButton) {
        stateButtons.forEach({ $0.backgroundColor = self.view.backgroundColor })
        sender.backgroundColor = UIColor.lightGray
        sectionView.ex.change(state: .normal)
    }
    
    @objc
    func setLoading(_ sender: UIButton) {
        stateButtons.forEach({ $0.backgroundColor = self.view.backgroundColor })
        sender.backgroundColor = UIColor.lightGray
        sectionView.ex.change(state: .loading)
    }
}
