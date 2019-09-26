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

extension UICollectionView {
    
    @objc override var isEmpty: Bool {
        let count = dataSource?.numberOfSections?(in: self) ?? numberOfSections
        return (0..<count).first(where: { self.numberOfItems(inSection: $0) > 0 }) == nil
    }
    
    @objc func emptyPage_insertItems(at indexPaths: [IndexPath]) {
        self.emptyPage_insertItems(at: indexPaths)
        setEmptyView(isEmpty)
    }
    
    @objc func emptyPage_deleteItems(at indexPaths: [IndexPath]) {
        self.emptyPage_deleteItems(at: indexPaths)
        setEmptyView(isEmpty)
    }
    
    @objc func emptyPage_insertSections(_ sections: IndexSet) {
        self.emptyPage_insertSections(sections)
        setEmptyView(isEmpty)
    }
    
    @objc func emptyPage_deleteSections(_ sections: IndexSet) {
        self.emptyPage_deleteSections(sections)
        setEmptyView(isEmpty)
    }
    
    @objc func emptyPage_reloadData() {
        self.emptyPage_reloadData()
        setEmptyView(isEmpty)
    }
    
}
