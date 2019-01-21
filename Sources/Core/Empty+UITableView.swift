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


extension UITableView {
  
@objc func emptyPage_layoutSubviews() {
    emptyPage_layoutSubviews()
    setEmptyView { }
  }
  
 @objc func emptyPage_layoutIfNeeded() {
    emptyPage_layoutIfNeeded()
    setEmptyView { }
  }
  
  @objc func emptyPage_insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.emptyPage_insertRows(at: indexPaths, with: animation)
    }
  }
  
  @objc func emptyPage_deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.emptyPage_deleteRows(at: indexPaths, with: animation)
    }
  }
  
  @objc func emptyPage_insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.emptyPage_insertSections(sections, with: animation)
    }
  }
  
  @objc func emptyPage_deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.emptyPage_deleteSections(sections, with: animation)
    }
  }
  
  @objc func emptyPage_reloadData() {
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.emptyPage_reloadData()
    }
  }
  
  func setEmptyView(event: () -> ()) {
    oldEmptyView?.removeFromSuperview()
    event()
    guard bounds.width != 0, bounds.height != 0 else { return }
    var isHasRows = false
    let sectionCount = dataSource?.numberOfSections?(in: self) ?? numberOfSections
    for index in 0..<sectionCount {
      if numberOfRows(inSection: index) > 0 {
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
