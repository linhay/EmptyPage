//
//  DemoSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/8/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DemoSection: BaseSection {

    override var title: String { "Demo" }

    override var rawModels: [IndexTextCell.Model] {
        DemoSet.allCases
    }

    override func didSelectItem(at row: Int) {
        guard let type = DemoSet.allCases.value(at: row) else {
            return
        }
        switch type {
        case .work_mjRefresh_cansScroll:
            let vc = TestMJRefreshCollectionVC()
            vc.config(canScroll: true)
            sectionView.st.viewController?.st.push(vc: vc)
        case .work_mjRefresh_cantScroll:
            let vc = TestMJRefreshCollectionVC()
            vc.config(canScroll: false)
            sectionView.st.viewController?.st.push(vc: vc)
        case .work_manager_noNetwork:
            break
        }
    }

}

enum DemoSet: String, CaseIterable, IndexTextCellModelProtocol {

    case work_mjRefresh_cansScroll = "MJRefresh 联动: 空页面时可滚动"
    case work_mjRefresh_cantScroll = "MJRefresh 联动: 空页面时不可滚动"
    case work_manager_noNetwork    = "manager: 配置自动切换无网络状态空页面"

    var title: String { rawValue }
    var text: String { "" }

}
