//
//  DemoScrollViewController.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/16.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage
import Stem
import MJRefresh

class DemoScrollViewController: UIViewController {

    private let scrollView = UIScrollView()

    lazy var itemView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 60)
        label.text = "点击重新加载"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
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
            self.scrollView.ep.isShow ? self.scrollView.insertSubview(self.itemView, at: 0) : self.itemView.removeFromSuperview()
            self.scrollView.mj_header?.endRefreshing()
        }
    }

}

extension DemoScrollViewController {

    fileprivate func buildUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        buildLayout()
        buildSubView()
    }

    private func buildLayout() {
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }

    private func buildSubView() {
        scrollView.ep.setEmpty(EmptyStore.demo.standard(tapEvent: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.refresh()
        }))
        scrollView.ep.isScrollEnabled = true
        scrollView.contentSize = view.bounds.size
        scrollView.ep.setSupplementaryView([MJRefreshNormalHeader.self])
        scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
        //    scrollView.showsVerticalScrollIndicator = false
        //    scrollView.showsHorizontalScrollIndicator = false
        scrollView.insertSubview(itemView, at: 0)
        itemView.st.setTapGesture {[weak self] _ in
            guard let self = self else {
                return
            }
            self.refresh()
        }
    }

}
