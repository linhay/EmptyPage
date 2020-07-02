//
//  StateManager.swift
//  EmptyPage_Example
//
//  Created by 林翰 on 2020/7/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import EmptyPage

class StateManager: EmptyPageCollectionViewManager {

    enum State: Int {
        case loading
        case normal
    }

    private(set) var state: State = .normal
    private(set) var emptyViewStore: [State: UIView] = [:]

    override var emptyViewProvider: () -> UIView? {
        return { [weak self] () -> UIView? in
            guard let self = self else {
                return nil
            }
            return self.emptyViewStore[self.state]
        }
    }

    func change(state: State) {
        self.state = state
        reload()
    }

    func set(emptyView: UIView?, for state: State) {
        emptyViewStore[state] = emptyView
    }

    override func set(emptyViewProvider provider: (() -> UIView?)?) { }

}

extension EmptyPage where Base: UICollectionView {

    func set(emptyView: UIView?, for state: StateManager.State) {
        if manager == nil || (manager is StateManager) == false {
            self.set(manager: StateManager())
        }

        guard let manager = manager as? StateManager else {
            return
        }

        manager.set(emptyView: emptyView, for: state)
    }

    func change(state: StateManager.State) {
        guard let manager = manager as? StateManager else {
            return
        }
        manager.change(state: state)
    }

}
