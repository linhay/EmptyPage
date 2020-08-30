//
//  ToolbarViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import SnapKit

class TestViewController<ContentView: UIView>: UIViewController {

    let toolbarView = SectionCollectionView()
    lazy var manager = SectionCollectionManager(sectionView: toolbarView)
    let contentView: ContentView

    let onAppear = Delegate<Void, Void>()
    let onDisAppear = Delegate<Void, Void>()

    init(contentView: ContentView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onAppear.call()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onDisAppear.call()
    }

    func config(toolItems: [ToolItem<ContentView>]) {
        let section = ToolbarSection(list: toolItems, target: contentView)
        manager.update(section)
        if isViewLoaded {
            manager.reload()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(0xfafafa)
        view.st.addSubviews(contentView, toolbarView)
        toolbarView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(toolbarView.snp.top)
        }
    }

}
