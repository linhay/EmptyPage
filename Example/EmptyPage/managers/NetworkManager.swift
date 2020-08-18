//
//  NetworkManager.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/7/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
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
