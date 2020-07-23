//
//  IndexManagerSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/26.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stuart
import Stem
import EmptyPage

class IndexManagerSection: SectionCollectionProtocol {

    var core: SectionCore?

    var itemCount: Int = 4

    func config(sectionView: UICollectionView) {
        sectionView.st.register(IndexTextCell.self)
        sectionView.st.register(IndexHeaderView.self, for: .header)
    }

    var headerSize: CGSize {
        return IndexHeaderView.preferredSize(collectionView: sectionView, model: nil)
    }

    var headerView: UICollectionReusableView? {
        let view = dequeue(kind: .header) as IndexHeaderView
        view.config("Manager")
        view.tapEvent.delegate(on: self) { (self, _) in
            self.itemCount = self.itemCount == 4 ? 4 : 1
            self.reload()
        }
        return view
    }

    func itemSize(at row: Int) -> CGSize {
        return IndexTextCell.preferredSize(collectionView: sectionView, model: nil)
    }

    func item(at row: Int) -> UICollectionViewCell {
        let cell: IndexTextCell = dequeue(at: row)
        switch row {
        case 0: cell.config(title: "NetworkManager", text: "无网络状态 - 空白页切换")
        case 1: cell.config(title: "NetworkManager - Config", text: "全局配置无网络状态 - 空白页切换")
        case 2: cell.config(title: "StateManager", text: "多状态 - 空白页切换")
        case 3: cell.config(title: "CustomViewManager", text: "自定义 UIView 空白页管理器")
        default:
            break
        }
        return cell
    }

    func didSelectItem(at row: Int) {
        let contentView = SectionCollectionView()
        var toolItems = [ToolItem<SectionCollectionView>]()
        let vc  = TestViewController(contentView: contentView)

        switch row {
        case 0:
            contentView.ep.set(manager: NetworkManager())
            setEmptyPage(contentView: contentView)
            toolItems = enableNetworkItems()
        case 1:
            let item = ToolItem<SectionCollectionView>(title: "启用全局配置")
            item.action.delegate(on: self) { [weak vc] (self, contentView) in
                EmptyPageConfig.shared.setGloalManager(collectionView: NetworkManager())
                self.setEmptyPage(contentView: contentView)
                var item = item
                item.canSelect = false
                vc?.config(toolItems: [item] + self.enableNetworkItems())
            }

            vc.onDisAppear.delegate(on: self) { (self, _) in
                EmptyPageConfig.shared.setGloalManager(collectionView: nil)
            }

            toolItems = [item]
        case 2:
            contentView.ep.set(emptyView: EmptyStore.loading, for: .loading)
            contentView.ep.set(emptyView: EmptyStore.dzn.airbnb.view(), for: .normal)
            do {
                let item = ToolItem<SectionCollectionView>(title: "loading")
                item.action.delegate(on: self) { (self, contentView) in
                    contentView.ep.change(state: .loading)
                }
                toolItems.append(item)
            }

            do {
                let item = ToolItem<SectionCollectionView>(title: "normal")
                item.action.delegate(on: self) { (self, contentView) in
                    contentView.ep.change(state: .normal)
                }
                toolItems.append(item)
            }
        case 3:
            let contentView = UIView()
            let vc = TestViewController(contentView: contentView)
            sectionView.st.viewController?.st.push(vc: vc)
            contentView.ep.set(manager: CustomViewManager())
            contentView.ep.set(emptyView: EmptyStore.dzn.airbnb.view())
            let placeholderView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
            placeholderView.backgroundColor = UIColor.st.random
            var toolItems = [ToolItem<UIView>]()
            do {
                let item = ToolItem<UIView>(title: "add view and reload")
                item.action.delegate(on: self) { (self, contentView) in
                    placeholderView.removeFromSuperview()
                    contentView.addSubview(placeholderView)
                    contentView.ep.reload()
                }
                toolItems.append(item)
            }

            do {
                let item = ToolItem<UIView>(title: "remove view and reload")
                item.action.delegate(on: self) { (self, contentView) in
                    placeholderView.removeFromSuperview()
                    contentView.ep.reload()
                }
                toolItems.append(item)
            }
            vc.config(toolItems: toolItems)
            return
        default:
            break
        }

        contentView.backgroundColor = .white
        sectionView.st.viewController?.st.push(vc: vc)
        vc.config(toolItems: toolItems)
    }

}

extension IndexManagerSection {

    func setEmptyPage(contentView: SectionCollectionView) {
        contentView.ep.set(emptyView: EmptyPageView.Template.image
            .set(image: UIImage(color: .red, size: .init(width: 60, height: 60)))
            .mix())
    }

    func enableNetworkItems() -> [ToolItem<SectionCollectionView>] {
        var toolItems = [ToolItem<SectionCollectionView>]()
        do {
            let item = ToolItem<SectionCollectionView>(title: "开启网络")
            item.action.delegate(on: self) { (self, contentView) in
                let manager = contentView.ep.manager as? NetworkManager
                manager?.noNetwork = false
                contentView.ep.reload()
            }
            toolItems.append(item)
        }

        do {
            let item = ToolItem<SectionCollectionView>(title: "关闭网络")
            item.action.delegate(on: self) { (self, contentView) in
                let manager = contentView.ep.manager as? NetworkManager
                manager?.noNetwork = true
                contentView.ep.reload()
            }
            toolItems.append(item)
        }
        return toolItems
    }

}
