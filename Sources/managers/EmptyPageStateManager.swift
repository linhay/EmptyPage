//
//  EmptyPage
//
//  Copyright (c) 2018 linhey - https://github.com/linhay
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

import UIKit

public protocol EmptyPageStateProtocol: class {
    associatedtype State: OptionSet & Hashable
    var state: State { get set }
    var emptyViewProvider: () -> UIView? { get }
    var viewStore: [State: UIView] { get set }
    var hookProvider: EmptyPageDelegate<State, UIView?> { get }
}

public extension EmptyPageStateProtocol where Self: EmptyPageViewManager {

    func change(state: State) {
        self.state = state
        reload()
    }

    func set(emptyView: UIView?, for state: State) {
        viewStore[state] = emptyView
    }

}

open class EmptyPageViewStateManager<State: OptionSet & Hashable>: EmptyPageViewManager, EmptyPageStateProtocol {

    open var state: State
    open var viewStore: [State: UIView] = [:]
    public let hookProvider = EmptyPageDelegate<State, UIView?>()

    open override var emptyViewProvider: () -> UIView? {
        return { [weak self] in
            guard let self = self else {
                return nil
            }
            if let view = self.hookProvider.call(self.state) {
                return view
            }
            return self.viewStore[self.state]
        }
    }

    public init(state: State) {
        self.state = state
        super.init()
    }

}

open class EmptyPageScrollViewStateManager<State: OptionSet & Hashable>: EmptyPageScrollViewManager, EmptyPageStateProtocol {

    open var state: State
    open var viewStore: [State: UIView] = [:]
    public let hookProvider = EmptyPageDelegate<State, UIView?>()

    open override var emptyViewProvider: () -> UIView? {
        return { [weak self] in
            guard let self = self else {
                return nil
            }
            if let view = self.hookProvider.call(self.state) {
                return view
            }
            return self.viewStore[self.state]
        }
    }

    public init(state: State) {
        self.state = state
        super.init()
    }

}

open class EmptyPageCollectionStateManager<State: OptionSet & Hashable>: EmptyPageCollectionViewManager, EmptyPageStateProtocol {

    open var state: State
    open var viewStore: [State: UIView] = [:]
    public let hookProvider = EmptyPageDelegate<State, UIView?>()

    open override var emptyViewProvider: () -> UIView? {
        return { [weak self] in
            guard let self = self else {
                return nil
            }
            if let view = self.hookProvider.call(self.state) {
                return view
            }
            return self.viewStore[self.state]
        }
    }

    public init(state: State) {
        self.state = state
        super.init()
    }

}

open class EmptyPageTableStateManager<State: OptionSet & Hashable>: EmptyPageTableViewManager, EmptyPageStateProtocol {

    open var state: State
    open var viewStore: [State: UIView] = [:]
    public let hookProvider = EmptyPageDelegate<State, UIView?>()

    open override var emptyViewProvider: () -> UIView? {
        return { [weak self] in
            guard let self = self else {
                return nil
            }
            if let view = self.hookProvider.call(self.state) {
                return view
            }
            return self.viewStore[self.state]
        }
    }

    public init(state: State) {
        self.state = state
        super.init()
    }

}
