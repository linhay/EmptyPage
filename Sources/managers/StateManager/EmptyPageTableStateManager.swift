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

open class EmptyPageTableStateManager<State: OptionSet & Hashable>: EmptyPageTableViewManager, EmptyPageStateProtocol, EmptyPageStateScorllableProtocol {

    public var scrollableStore: [State: Bool] = [:]
    open var state: State
    open var viewStore: [State: UIView] = [:]
    public let hookProvider = EmptyPageDelegate<State, UIView?>()
    open override var emptyViewProvider: () -> UIView? {
        get { viewProvider }
        set { _ = newValue }
    }
    
    public init(state: State) {
        self.state = state
        super.init()
    }

    open override func reload(completion: ((Bool) -> Void)? = nil) {
        ep_state_reload(completion: completion)
    }

}
