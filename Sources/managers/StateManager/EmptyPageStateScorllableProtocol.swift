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

public protocol EmptyPageStateScorllableProtocol: class {
    associatedtype State: OptionSet & Hashable

    var scrollableStore: [State: Bool] { get set }
    func set(canScroll: Bool, for state: State)
}

public extension EmptyPageStateScorllableProtocol {

    func set(canScroll: Bool, for state: State) {
        scrollableStore[state] = canScroll
    }

}

/// 默认逻辑代码 
public extension EmptyPageStateScorllableProtocol where Self: EmptyPageScrollViewManager & EmptyPageStateProtocol {

    private var viewProvider: () -> UIView? {
        return { [weak self] in
            guard let self = self else {
                return nil
            }
            if let box = self.hookProvider.call(self.state), let view = box {
                return view
            }
            return self.viewStore[self.state]
        }
    }

    func ep_state_reload(completion: ((Bool) -> Void)?) {
        let isShow = self.isShow
        ep_reload { [weak self] isEmpty in
            guard let self = self else {
                return
            }
            if isEmpty {
                self.canScrollEnabled = self.scrollableStore[self.state] ?? false
            }
            self.canScroll(isShowBeforeReload: isShow, isEmptyAfterReload: isEmpty)
            completion?(isEmpty)
        }
    }

}
