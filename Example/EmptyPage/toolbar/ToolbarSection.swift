//
//  ToolbarSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem

struct ToolItem<View> {
    let title: String
    var isSelect: Bool = false
    var canSelect: Bool = true
    let action = Delegate<View, Void>()
}

class ToolbarSection<View: UIView>: SectionCollectionProtocol {

    var core: SectionCore?

    var itemCount: Int { list.count }

    let list: [ToolItem<View>]
    unowned var target: View

    init(list: [ToolItem<View>], target: View) {
        self.list = list
        self.target = target
    }

    func config(sectionView: UICollectionView) {
        sectionView.st.register(ToolbarCell.self)
    }

    func itemSize(at row: Int) -> CGSize {
        ToolbarCell.preferredSize(collectionView: sectionView, model: list.value(at: row)?.title)
    }

    func item(at row: Int) -> UICollectionViewCell {
        let cell = dequeue(at: row) as ToolbarCell
        if let model = list.value(at: row) {
            cell.config(model.title, isSelect: model.isSelect, canSelect: model.canSelect)
        }
        return cell
    }

    func didSelectItem(at row: Int) {
        guard let model = list.value(at: row), model.canSelect else {
            return
        }
        model.action.call(target)
    }

}
