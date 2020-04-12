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

class IndexViewController: SectionController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var models = [IndexModel]()

        do {
            let model = IndexModel(title: "collectionView")
            models.append(model)
            model.delegate.delegate(on: self) { (self, _) in
                self.st.push(vc: DemoCollectionViewController())
            }
        }

        do {
            let model = IndexModel(title: "tableView")
            models.append(model)
            model.delegate.delegate(on: self) { (self, _) in
                self.st.push(vc: DemoTableViewController())
            }
        }

        do {
            let model = IndexModel(title: "scrollView")
            models.append(model)
            model.delegate.delegate(on: self) { (self, _) in
                self.st.push(vc: DemoScrollViewController())
            }
        }

        let demoSection = IndexSection(collectionView: sectionView, models: models)
        manager.update(sections: demoSection)
    }

}
