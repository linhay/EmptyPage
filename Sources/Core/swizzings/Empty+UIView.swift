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

extension UIView {
    
     enum EmptyPageViewKey {
        static let manager = UnsafeRawPointer(bitPattern: "EmptyPage.uiview.ep.manager".hashValue)!
        static let useCustomManager = UnsafeRawPointer(bitPattern: "EmptyPage.uiview.ep.useCustomManager".hashValue)!
    }

    var useCustomManager: Bool {
        set { objc_setAssociatedObject(self, EmptyPageViewKey.useCustomManager, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { return objc_getAssociatedObject(self, EmptyPageViewKey.useCustomManager) as? Bool ?? false }
    }

     var emptyPageViewManager: EmptyPageViewManager? {
        set { objc_setAssociatedObject(self, EmptyPageViewKey.manager, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
        get { return objc_getAssociatedObject(self, EmptyPageViewKey.manager) as? EmptyPageViewManager }
    }

    @objc func emptyPage_layoutSubviews() {
        emptyPage_layoutSubviews()
        emptyPageViewManager?.resize()
    }

    @objc func emptyPage_layoutIfNeeded() {
        emptyPage_layoutIfNeeded()
        emptyPageViewManager?.resize()
    }
}
