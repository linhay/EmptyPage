//
//  IndexDribbbleSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import EmptyPage

class DribbbleSection: BaseSection {

    override var title: String { "Dribbble" }
    override var rawModels: [IndexTextCell.Model] { Dribbble.allCases }

    override func didSelectItem(at row: Int) {
        guard let item = Dribbble.allCases.value(at: row) else {
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


enum Dribbble: String, CaseIterable, IndexTextCellModelProtocol {
    case illustration
    var title: String { rawValue }
    var text: String { link }
    var website: String { "dribbble.com" }
    var link: String {
        switch self {
        case .illustration:
            return "https://dribbble.com/shots/2586577-404-page-Illustration"
        }
    }
    func view() -> EmptyPageView {
        switch self {
        case .illustration:
            return EmptyPageView.Template.standard
                .config(imageView: { $0.set(image: UIImage(named: "404")!) })
                .layout(view: .titleLabel, types: .afterSpac(0))
                .config(titleLabel: {
                    $0.set(text: "FILE NOT FOUND",
                           color: UIColor("#849aac"),
                           font: UIFont.boldSystemFont(ofSize: 18))
                })
                .config(textLabel: {
                    $0.set(text: "Lorem ipsum dolor sit amet.\nconectetur adipscing elit sed do eiusmod",
                           color: UIColor("#c5cfd7"))
                })
                .config(button: {
                    $0.isHidden = true
                })
                .mix()
                .set(backgroundColor: UIColor("#f5f7f9"))
        }
    }
}
