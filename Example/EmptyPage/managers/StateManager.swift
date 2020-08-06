//
//  CollectionView+EmptyStateManager.swift
//  iDxyer
//
//  Created by 林翰 on 2020/8/5.
//

import UIKit
import EmptyPage
import Reachability

public class StateManager: EmptyPageCollectionViewManager {

    public enum State: Int {
        case loading
        case normal
        case noNetwork
    }

    private(set) var state: State = .normal
    private(set) var emptyViewStore: [State: UIView] = [:]

    override init() {
        super.init()
        set(emptyViewProvider: { [weak self] () -> UIView? in
            guard let self = self else {
                return nil
            }

            if AppManager.shared.reachability.connection == .unavailable, let view = self.emptyViewStore[.noNetwork] {
                return view
            }

            return self.emptyViewStore[self.state]
        })
    }

    public override func set(emptyView view: UIView?) { }

}

public extension StateManager {

    func change(state: State) {
        self.state = state
        reload()
    }

    func set(emptyView: UIView?, for state: State) {
        emptyViewStore[state] = emptyView
    }

}

public extension EmptyPage where Base: UICollectionView {

    func set(emptyView: UIView?, for state: StateManager.State) {
        if manager == nil || (manager is StateManager) == false {
            let manager = StateManager()
            manager.set(target: base)
            self.set(manager: manager)
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
