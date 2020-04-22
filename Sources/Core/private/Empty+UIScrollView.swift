//
//  EmptyPage
//
//  Copyright (c) 2018 linhay - https://github.com/linhay
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

extension UIScrollView {

    /// 类型限制于除 [UICollectionView, UITableView] 外的 UIScrollView与子类
    /// - Returns: 条件是否成立
    func isSubClassOfScrollView() -> Bool {
        if self.isKind(of: UITableView.self) {
            return false
        } else if self.isKind(of: UICollectionView.self) {
            return false
        } else if self.isKind(of: UIScrollView.self) {
            return true
        }
        return false
    }
    
    private func needReload(view: UIView) -> Bool {
        guard view !== emptyView else {
            return false
        }
        
        guard view.description.contains("_UIScrollViewScrollIndicator") == false else {
            return false
        }
        
        guard ep_supplementaryView.contains(where: { $0 == type(of: view) }) == false else {
            return false
        }
        
        return true
    }
    
    @objc func emptyPage_insertSubview(_ view: UIView, at index: Int) {
        emptyPage_insertSubview(view, at: index)
        guard needReload(view: view) else {
            return
        }
        reloadEmptyView(isEmpty: false)
    }
    
    @objc func emptyPage_addSubview(_ view: UIView) {
        emptyPage_addSubview(view)
        guard isSubClassOfScrollView() else {
            return
        }
        guard needReload(view: view) else {
            return
        }
        reloadEmptyView(isEmpty: false)
    }
    
    @objc func emptyPage_willRemoveSubview(_ subview: UIView) {
        emptyPage_willRemoveSubview(subview)
        guard isSubClassOfScrollView() else {
            return
        }
        guard subview !== emptyView else {
            return
        }
        
        let isEmpty = subviews.filter({ view -> Bool in
            guard needReload(view: view) && view !== subview else {
                return false
            }
            return true
        }).isEmpty
        
        reloadEmptyView(isEmpty: isEmpty)
    }
    
}
