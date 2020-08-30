//
//  BaseSection.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/8/30.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem

class BaseSection: SingleTypeSection<IndexTextCell> {
    
    var title: String { "" }
    
    var rawModels: [IndexTextCell.Model] { [] }

    override init(_ models: [IndexTextCellModelProtocol] = []) {
        super.init(models)
        config(models: rawModels)
    }

    override func config(sectionView: UICollectionView) {
        super.config(sectionView: sectionView)
        sectionView.st.register(IndexHeaderView.self, for: .header)
    }
    
    override var headerSize: CGSize {
        return IndexHeaderView.preferredSize(collectionView: sectionView, model: nil)
    }
    
    override var headerView: UICollectionReusableView? {
        let view = dequeue(kind: .header) as IndexHeaderView
        view.config(title)
        view.tapEvent.delegate(on: self) { (self, _) in
            self.config(models: self.models.count > 1 ? [self.rawModels[0]] : self.rawModels)
            self.reload()
        }
        return view
    }
    
}
