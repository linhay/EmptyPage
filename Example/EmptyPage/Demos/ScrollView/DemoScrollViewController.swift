//
//  DemoScrollViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import SVProgressHUD
import MJRefresh
import Stem
import Stuart
import SnapKit

class DemoScrollViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 500)
//        scrollView.ep.setSupplementaryView(MJRefreshNormalHeader.self)
        scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
//        scrollView.ep.setEmpty(EmptyStore.demo.standard(tapEvent: { [weak self] _ in
//            guard let self = self else {
//                return
//            }
//            self.refresh()
//        }))
        refresh()
    }
    
    @objc
    func refresh() {
        if scrollView.mj_header?.isRefreshing == false {
            scrollView.mj_header?.beginRefreshing()
            return
        }
        Gcd.delay(2) { [weak self] in
            guard let self = self else {
                return
            }
            self.insertItemsAction(UIButton())
            self.scrollView.mj_header?.endRefreshing()
        }
    }
    
    @IBAction func deleteItemsAction(_ sender: UIButton) {
        scrollView.subviews.last?.removeFromSuperview()
    }
    
    @IBAction func insertItemsAction(_ sender: UIButton) {
        let view = UIView()
        view.frame.origin = CGPoint(x: 0, y: scrollView.subviews.last?.frame.maxY ?? 0)
        view.frame.size = CGSize(width: scrollView.contentSize.width, height: 44)
        view.backgroundColor = UIColor.st.random
        scrollView.addSubview(view)
    }

    @IBAction func canScrollEnabledAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        scrollView.ep.canScrollEnabled = sender.isSelected
    }

}
