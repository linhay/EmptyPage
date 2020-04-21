//
//  IndexViewController.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/4/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Stem
import Stuart

class IndexViewController: SectionCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var models = [IndexModel]()

        do {
            let model = IndexModel(title: "CollectionView")
            models.append(model)
            model.delegate.delegate(on: self) { (self, _) in
                self.st.push(vc: DemoCollectionViewController())
            }
        }

        do {
            let model = IndexModel(title: "TableView")
            models.append(model)
            model.delegate.delegate(on: self) { (self, _) in
                self.st.push(vc: DemoTableViewController())
            }
        }

        do {
            let model = IndexModel(title: "ScrollView")
            models.append(model)
            model.delegate.delegate(on: self) { (self, _) in
                self.st.push(vc: DemoScrollViewController())
            }
        }

        let demoSection = IndexSection(models: models)
        demoSection.title = "demo"
        manager.update(demoSection)
    }

}
