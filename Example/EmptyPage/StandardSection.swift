//
//  IndexStandardSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import EmptyPage

enum Standard: String, CaseIterable, IndexTextCellModelProtocol {

    case image_normal    = "纯图片 - 静态图片"
    case image_animate   = "纯图片 - 动态图片"
    case text_normal     = "纯文字 - 单样式"
    case text_attributed = "纯文本 - 富文本样式"
    case standard        = "复合型"

    var title: String { rawValue }
    var text: String { desc() }

    func desc() -> String {
        switch self {
        case .image_normal:
            return "EmptyPageView.Template.image"
        case .image_animate:
            return "EmptyPageView.Template.image"
        case .text_normal:
            return "EmptyPageView.Template.text"
        case .text_attributed:
            return "EmptyPageView.Template.text"
        case .standard:
            return "EmptyPageView.Template.standard"
        }
    }

    func view() -> EmptyPageView {
        switch self {
        case .image_normal:
            return TemplateSet.image_normal().mix()
        case .image_animate:
            return TemplateSet.image_animate().mix()
        case .text_normal:
            return TemplateSet.text_normal().mix()
        case .text_attributed:
            return TemplateSet.text_attributed().mix()
        case .standard:
            return TemplateSet.standard1(tapEvent: nil).mix()
        }
    }
}

class StandardSection: BaseSection {

    override var title: String { "Standard" }
    override var rawModels: [IndexTextCell.Model] { Standard.allCases }

    override func didSelectItem(at row: Int) {
        guard let item = Standard.allCases.value(at: row) else {
            return
        }

        let vc = UITableViewController()
        vc.tableView.backgroundColor = .white
        vc.view.backgroundColor = .white
        vc.tableView.separatorStyle = .none
        vc.tableView.ep.set(emptyView: item.view())
        sectionView.st.viewController?.st.push(vc: vc)
    }

}
