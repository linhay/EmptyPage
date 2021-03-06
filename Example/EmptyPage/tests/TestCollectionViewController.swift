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

    fileprivate func createSection() -> TestSection<TestCollectionCell> {
        let section = TestSection<TestCollectionCell>(TestCollectionCell.Action.allCases)

        section.sectionInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        section.selectedEvent.delegate(on: self) { [weak section] (self, action) in
            guard let section = section else {
                return
            }
            switch action {
            case .add_row:
                section.insert(at: section.models.count) {
                    section.config(models: section.models + [.add_row])
                }
            case .add_section:
                self.manager.insert(section: self.createSection(), at: self.manager.sections.count)
            case .remove_row:
                section.delete(at: section.models.count - 1) {
                    var models = section.models
                    models.removeLast()
                    section.config(models: models)
                }
            case .remove_section:
                self.manager.delete(at: self.manager.sections.count - 1)
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

fileprivate class TestSection<Cell: UICollectionViewCell>: SectionCollectionProtocol where Cell: ConfigurableView & STViewProtocol {


    public private(set) var models: [Cell.Model]

    public let selectedEvent = Delegate<Cell.Model, Void>()
    public let selectedRowEvent = Delegate<Int, Void>()
    public let willDisplayEvent = Delegate<Int, Void>()
    /// cell 样式配置
    public let configCellStyleEvent = Delegate<(row: Int, cell: Cell), Void>()

    open var minimumLineSpacing: CGFloat = 0
    open var minimumInteritemSpacing: CGFloat = 0
    open var sectionInset: UIEdgeInsets = .zero

    public var core: SectionCore?
    open var itemCount: Int { models.count }

    public init(_ models: [Cell.Model] = []) {
        self.models = models
    }

    open func config(models: [Cell.Model]) {
        self.models = models
    }
    
    var hiddenHeaderWhenNoItem: Bool = false
    var hiddenFooterWhenNoItem: Bool = false
    
    var showHeader = true
    var showFooter = true
    
    var headerView: UICollectionReusableView? {
        guard showHeader else {
            return nil
        }
        let view = dequeue(kind: .header) as TestReusableView
        view.backgroundColor = .red
        view.st.onTapGesture {
            self.showHeader = false
            self.reload()
        }
        return view
    }
    
    var headerSize: CGSize {
        guard showHeader else {
            return .zero
        }
        return .init(width: sectionView.bounds.width, height: 44)
    }
    
    var footerView: UICollectionReusableView? {
        guard showFooter else {
            return nil
        }
        let view = dequeue(kind: .footer) as TestReusableView
        view.backgroundColor = .blue
        view.st.onTapGesture {
            self.showFooter = false
            self.reload()
        }
        return view
    }
    
    var footerSize: CGSize {
        guard showFooter else {
            return .zero
        }
        return  .init(width: sectionView.bounds.width, height: 44)
    }

    open func itemSize(at row: Int) -> CGSize {
        let width = sectionView.bounds.width - sectionInset.left - sectionInset.right
        return Cell.preferredSize(limit: .init(width: width,
                                               height: sectionView.bounds.height),
                                  model: models.value(at: row))
    }

    open func didSelectItem(at row: Int) {
        selectedEvent.call(models[row])
        selectedRowEvent.call(row)
    }

    open func config(sectionView: UICollectionView) {
        sectionView.st.register(Cell.self)
        sectionView.st.register(TestReusableView.self, for: .footer)
        sectionView.st.register(TestReusableView.self, for: .header)
    }

    open func item(at row: Int) -> UICollectionViewCell {
        let cell = dequeue(at: row) as Cell
        cell.config(models[row])
        configCellStyleEvent.call((row: row, cell: cell))
        return cell
    }

}

fileprivate class TestCollectionCell: UICollectionViewCell, ConfigurableView, STViewProtocol {

    enum Action: String, CaseIterable {
        case remove_row      = "移除 1 行 || delete last row"
        case remove_section  = "移除 1 组 || delete last section"
        case reload          = "刷新 || reloadData"
        case reload_noData   = "刷新 - 无数据 || reloadData without rows"
        case add_row         = "添加 1 行 || add a row at last"
        case add_section     = "添加 1 组 || add a section at last"
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
