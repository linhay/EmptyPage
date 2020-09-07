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

public class ExampleCollectionStateManager: EmptyPageCollectionStateManager<EmptyPageState> { }

public extension Example where Base: UICollectionView {

   private var manager: ExampleCollectionStateManager {
        if let manager = base.ep.manager as? ExampleCollectionStateManager {
            return manager
        } else {
            let manager = ExampleCollectionStateManager(state: .normal)
            manager.set(target: base)
            manager.hookProvider.delegate(on: base) { (self, state) -> UIView? in
                guard state == .normal, AppManager.shared.reachability.connection == .unavailable else {
                    return nil
                }
                manager.state = .noNetwork
                return manager.viewStore[.noNetwork]
            }
            base.ep.set(manager: manager)
            return manager
        }
    }

    func set(emptyView: UIView?, for state: EmptyPageState) {
        manager.set(emptyView: emptyView, for: state)
    }

    func set(canScroll: Bool, for state: EmptyPageState) {
        manager.scrollableStore[state] = canScroll
    }

    func change(state: EmptyPageState) {
        manager.set(state: state)
    }

}
