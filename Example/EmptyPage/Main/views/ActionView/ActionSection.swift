//
//  ActionSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2019/9/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import EmptyPage
import SVProgressHUD

class ActionSection: SectionTableType {

    var index: Int = 0

    unowned var sectionController: SectionTableViewController

    var itemCount: Int = 3

    var headerView: UITableViewHeaderFooterView? {
        let view = tableView.st.dequeue() as MainHeaderView
        view.config(title: "Action 示例") { [weak self] in
            guard let self = self else { return }
            self.itemCount = self.itemCount > 0 ? 0 : 3
            self.refresh()
        }
        return view
    }

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.st.dequeue(at: indexPath) as ActionCell
        switch indexPath.item {
        case 0:
            cell.configLeft(title: "全局添加 EmptyView") { (_) in
                SVProgressHUD.showSuccess(withStatus: "设置成功")
//                UIScrollView.ep.setGlobalEmpty { (_) -> UIView? in
//                    return EmptyViewStore.dz.airbnb.emptyView
//                }
            }

            cell.configRight(title: "移除全局 EmptyView") { (_) in
                SVProgressHUD.showSuccess(withStatus: "已取消")
//                UIScrollView.ep.setGlobalEmpty(nil)
            }
            return cell
        case 1:
            cell.configLeft(title: "全局添加 FirstLoadingView") { (_) in
                SVProgressHUD.showSuccess(withStatus: "设置成功")
//                UIScrollView.ep.setGlobalFirstLoading { (_) -> UIView? in
//                    return EmptyViewStore.loading.emptyView
//                }
            }

            cell.configRight(title: "移除全局 FirstLoadingView") { (_) in
                SVProgressHUD.showSuccess(withStatus: "已取消")
//                UIScrollView.ep.setGlobalFirstLoading(nil)
            }
            return cell
        case 2:
            cell.configLeft(title: "无配置的 TableView") {[weak self] (_) in
                let vc = UITableViewController()
                vc.tableView.separatorStyle = .none
                self?.sectionController.st.push(vc: vc)
                SVProgressHUD.showInfo(withStatus: "5s 后执行 ep.reload()")
                Gcd.delay(2) { SVProgressHUD.dismiss() }
                Gcd.delay(5) {
                    vc.tableView.ep.setEmpty(EmptyViewStore.dz.airbnb)
                    vc.tableView.ep.reload()
                    SVProgressHUD.showSuccess(withStatus: "已执行")
                }
            }

            cell.configRight(title: "无配置的 CollectionView") {[weak self] (_) in
                let vc = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
                self?.sectionController.st.push(vc: vc)
                SVProgressHUD.showInfo(withStatus: "5s 后执行 ep.reload()")
                Gcd.delay(2) { SVProgressHUD.dismiss() }
                Gcd.delay(5) {
                    vc.collectionView.ep.setEmpty(EmptyViewStore.dz.airbnb)
                    vc.collectionView.ep.reload()
                    SVProgressHUD.showSuccess(withStatus: "已执行")
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

    init(_ sectionController: SectionTableViewController) {
        self.sectionController = sectionController
        tableView.st.register(ActionCell.self)
        tableView.st.register(MainHeaderView.self)
    }

}
