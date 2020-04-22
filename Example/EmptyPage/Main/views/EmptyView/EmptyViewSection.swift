//
//  EmptyViewSection.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/9/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
import Stem

class EmptyViewSection: SectionTableType {

    unowned var sectionController: SectionTableViewController
    var index: Int = 0
    var itemCount: Int = 4

    init(_ sectionController: SectionTableViewController) {
        self.sectionController = sectionController
        tableView.st.register(EmptyViewSectionCell.self)
        tableView.st.register(MainHeaderView.self)
    }

    func cell(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.st.dequeue(at: indexPath) as EmptyViewSectionCell
        switch indexPath.item {
        case 0: cell.config(title: "TableView 示例")
        case 1: cell.config(title: "CollectionView 示例")
        case 2: cell.config(title: "ScrollView 示例")
        case 3: cell.config(title: "旧版示例入口")
        default: break
        }
        return cell
    }

    var headerView: UITableViewHeaderFooterView? {
        let view = tableView.st.dequeue() as MainHeaderView
        view.config(title: "EmptyPage 示例") { [weak self] in
            guard let self = self else { return }
            self.itemCount = self.itemCount > 0 ? 0 : 4
            self.refresh()
        }
        return view
    }

    func didSelectItem(at index: Int) {
        let vc: UIViewController
        switch index {
        case 0: vc = UITableViewController()
        case 1: vc = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        case 2:
            vc = UIViewController()
            vc.view.backgroundColor = .white
            let scrollView = UIScrollView()
            scrollView.frame = vc.view.bounds
            scrollView.contentSize = CGSize(width: vc.view.bounds.width * 2, height: vc.view.bounds.height)
            vc.view.addSubview(scrollView)
        case 3: vc = HomeViewController()
        default: vc = UIViewController()
        }
        sectionController.st.push(vc: vc)
    }

}
