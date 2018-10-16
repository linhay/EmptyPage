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
extension UITableView {
  
  @objc func table_emptyLayoutSubviews() {
    table_emptyLayoutSubviews()
    setEmptyView { }
  }
  
  @objc func table_emptyLayoutIfNeeded() {
    table_emptyLayoutIfNeeded()
    setEmptyView { }
  }
  
  @objc func table_emptyInsertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyInsertRows(at: indexPaths, with: animation)
    }
  }
  
  @objc func table_emptyDeleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyDeleteRows(at: indexPaths, with: animation)
    }
  }
  
  @objc func table_emptyInsertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyInsertSections(sections, with: animation)
    }
  }
  
  @objc func table_emptyDeleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation){
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyDeleteSections(sections, with: animation)
    }
  }
  
  @objc func table_emptyReloadData() {
    setEmptyView {[weak self] in
      guard let base = self else { return }
      base.table_emptyReloadData()
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
