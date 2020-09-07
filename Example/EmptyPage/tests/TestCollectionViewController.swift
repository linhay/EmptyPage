//
//  TestCollectionViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/9/7.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class TestCollectionViewController: SectionCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        sectionView.ep.setEmpty(TemplateSet.standard1(tapEvent: { [weak self] in
            self?.loadData()
        }))

        loadData()
    }

    fileprivate func loadData() {
        manager.update([createSection()])
    }

    fileprivate func createSection() -> SingleTypeSection<TestCollectionCell> {
        let section = SingleTypeSection<TestCollectionCell>(TestCollectionCell.Action.allCases)

        section.selectedEvent.delegate(on: self) { [weak section] (self, action) in
            guard let section = section else {
                return
            }
            switch action {
            case .add_row:
                section.config(models: section.models + [.add_row])
            case .add_section:
                self.manager.update(self.manager.sections + [self.createSection()])
            case .remove_row:
                var models = section.models
                models.removeLast()
                section.config(models: models)
            case .remove_section:
                var models = self.manager.sections
                models.removeLast()
                self.manager.update(models)
            case .reload:
                self.manager.reload()
            case .reload_noData:
                self.manager.update([])
            }
        }

        section.configCellStyleEvent.delegate(on: self) { [weak section] (self, result) in
            guard let section = section else {
                return
            }
            let (row, cell) = result
            cell.config(desc: "section: \(section.index), row: \(row)")
        }

        return section
    }
    
}

fileprivate class TestCollectionCell: UICollectionViewCell, ConfigurableView, STViewProtocol {

    enum Action: String, CaseIterable {
        case remove_row      = "移除 1 行"
        case remove_section  = "移除 1 组"
        case reload          = "刷新"
        case reload_noData   = "刷新 - 无数据"
        case add_row         = "添加 1 行"
        case add_section     = "添加 1 组"
    }

    static func preferredSize(limit size: CGSize, model: Action?) -> CGSize {
        return .init(width: size.width, height: 50)
    }

    private let textLabel: UILabel = .init()
    private let descLabel: UILabel = .init()
    private let line: UIView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(desc: String) {
        descLabel.text = desc
    }

    func config(_ model: Action) {
        textLabel.text = model.rawValue
    }

    private func setupUI() {
        textLabel.font = .systemFont(ofSize: 15)
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(contentView.snp.centerY)
            make.height.equalTo(15)
        }

        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = .lightGray
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(contentView.snp.centerY)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(12)
        }

        contentView.addSubview(line)
        line.backgroundColor = .black
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }

}
