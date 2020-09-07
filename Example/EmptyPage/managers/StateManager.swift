//
//  CollectionView+EmptyStateManager.swift
//  iDxyer
//
//  Created by 林翰 on 2020/8/5.
//

import UIKit
import EmptyPage
import Reachability

public struct EmptyPageState: OptionSet, Hashable {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    static let normal    = EmptyPageState(rawValue: 1)
    static let loading   = EmptyPageState(rawValue: 2)
    static let noNetwork = EmptyPageState(rawValue: 3)
}

class ExampleCollectionStateManager: EmptyPageCollectionStateManager<EmptyPageState> { }

public extension EmptyPage where Base: UICollectionView {

    func set(emptyView: UIView?, for state: EmptyPageState) {
        if manager == nil || (manager is ExampleCollectionStateManager) == false {
            let manager = ExampleCollectionStateManager(state: .normal)
            manager.set(target: base)
            manager.hookProvider.delegate(on: base) { (self, state) -> UIView? in
                guard state == .normal, AppManager.shared.reachability.connection == .unavailable else {
                    return nil
                }
                manager.state = .noNetwork
                return manager.viewStore[.noNetwork]
            }
            self.set(manager: manager)
        }

        guard let manager = manager as? ExampleCollectionStateManager else {
            return
        }

        manager.set(emptyView: emptyView, for: state)
    }

    func change(state: EmptyPageState) {
        guard let manager = manager as? ExampleCollectionStateManager else {
            return
        }
        manager.set(state: state)
    }

}
