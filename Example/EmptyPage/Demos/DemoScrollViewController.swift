//
//  DemoScrollViewController.swift
//  EmptyPage_Example
//
//  Created by linhay on 2018/1/16.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

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
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    sleep(3) {
      self.itemView.removeFromSuperview()
      sleep(3, mainCall: {
        self.scrollView.setEmpty(EmptyStore.custom(block1: {
          
          }, block2: {
            
        }))
      })
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
    scrollView.setEmpty(EmptyStore.loading)
    scrollView.contentSize = view.bounds.size
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.addSubview(itemView)
  }

}


extension DemoScrollViewController {


}
