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

@objc
extension UICollectionView {
  
  @objc func coll_emptyLayoutSubviews() {
    coll_emptyLayoutSubviews()
    setEmptyView {}
  }
  
  @objc func coll_emptyLayoutIfNeeded() {
    coll_emptyLayoutIfNeeded()
    setEmptyView {}
  }
  
  @objc func coll_emptyInsertItems(at indexPaths: [IndexPath]){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyInsertItems(at: indexPaths)
    }
  }
  
  @objc func coll_emptyDeleteItems(at indexPaths: [IndexPath]){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyDeleteItems(at: indexPaths)
    }
  }
  
  @objc func coll_emptyInsertSections(_ sections: IndexSet){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyInsertSections(sections)
    }
  }
  
  @objc func coll_emptyDeleteSections(_ sections: IndexSet){
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyDeleteSections(sections)
    }
  }
  
  @objc func coll_emptyReloadData() {
    setEmptyView { [weak self] in
      guard let base = self else { return }
      base.coll_emptyReloadData()
    }
  }
  
  func setEmptyView(event: () -> ()) {
    oldEmptyView?.removeFromSuperview()
    event()
    guard bounds.width != 0, bounds.height != 0 else { return }
    var isHasRows = false
    let sectionCount = dataSource?.numberOfSections?(in: self) ?? numberOfSections
    for  index in 0..<sectionCount {
      if numberOfItems(inSection: index) > 0 {
        isHasRows = true
        break
      }
    }

    isScrollEnabled = isHasRows
    if isHasRows {
      emptyView?.removeFromSuperview()
      return
    }
    
    guard let view = emptyView else{ return }
    view.frame = bounds
    addSubview(view)
    sendSubview(toBack: view)
  }
  
}

