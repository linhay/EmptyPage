//
//  SectionTableViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2019/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SectionTableViewController: UIViewController {

    private var sections = [SectionTableType]()

    let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - sections
extension SectionTableViewController {

    func update(sections: [SectionTableType]) {
        self.sections = sections.enumerated().map({ (offset, element) -> SectionTableType in
            var element = element
            element.index = offset
            return element
        })
    }

}

extension SectionTableViewController {

   private func setupUI() {
        view.addSubview(tableView)
        setupLayout()
        setupSubviews()
    }

   private func setupLayout() {
        tableView.frame = view.bounds
    }

   private func setupSubviews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

}


// MARK: - UITableViewDataSource
extension SectionTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sections[indexPath.section].cell(tableView: tableView, at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].footerView
    }

}


// MARK: - UITableViewDelegate
extension SectionTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].didSelectItem(at: indexPath.item)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].itemHeights[indexPath.item]
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight
    }
    
}
