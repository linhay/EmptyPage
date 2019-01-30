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
    sleep(5) {
      self.itemView.removeFromSuperview()
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
    scrollView.frame = view.bounds
  }

  private func buildSubView() {
    scrollView.emptyView = EmptyStore.loading
    scrollView.contentSize = view.bounds.size
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.addSubview(itemView)
  }

}


extension DemoScrollViewController {


}
