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
  
  fileprivate var isEmpty: Bool {
    let count = dataSource?.numberOfSections?(in: self) ?? numberOfSections
    return (0..<count).first(where: { self.numberOfRows(inSection: $0) > 0 }) == nil
  }
  
  @objc func emptyPage_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation){
    self.emptyPage_insertRows(at: indexPaths, with: animation)
    setEmptyView(isEmpty)
  }
  
  @objc func emptyPage_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation){
    self.emptyPage_deleteRows(at: indexPaths, with: animation)
    setEmptyView(isEmpty)
  }
  
  @objc func emptyPage_insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation){
    self.emptyPage_insertSections(sections, with: animation)
    setEmptyView(isEmpty)
    
  }
  
  @objc func emptyPage_deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation){
    self.emptyPage_deleteSections(sections, with: animation)
    setEmptyView(isEmpty)
  }
  
  @objc func emptyPage_reloadData() {
    self.emptyPage_reloadData()
    setEmptyView(isEmpty)
  }
  
}
