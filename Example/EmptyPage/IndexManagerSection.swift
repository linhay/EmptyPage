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

class NetworkManager: EmptyPageCollectionViewManager {
    
    var noNetwork: Bool = false

    override func set(emptyViewProvider provider: (() -> UIView?)?) {
        super.set(emptyViewProvider: { [weak self] () -> UIView? in
            guard let self = self else {
                return nil
            }
            if self.noNetwork {
                return EmptyPageView.Template.text
                    .set(text: "no network")
                    .mix()
            }
            return provider?()
        })
    }

}

class IndexManagerSection: SectionCollectionProtocol {

    var core: SectionCore?

    var itemCount: Int = 3

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
            self.itemCount = self.itemCount == 3 ? 3 : 1
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
        case 1: cell.config(title: "Config - NetworkManager", text: "全局配置无网络状态 - 空白页切换")
        case 2: cell.config(title: "StateManager", text: "多状态 - 空白页切换")
        default:
            break
        }
        return cell
    }

    func didSelectItem(at row: Int) {
        let contentView = SectionCollectionView()
        contentView.backgroundColor = .white

        var toolItems = [ToolItem<SectionCollectionView>]()
        let vc  = TestViewController(contentView: contentView)
        sectionView.st.viewController?.st.push(vc: vc)

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
        default:
            break
        }

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
