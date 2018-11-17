![title](./imgs/title.png)

[![build](https://travis-ci.org/linhay/EmptyPage.svg?branch=master)](https://travis-ci.org/BLFoundation/EmptyPage)
![Swift4](https://img.shields.io/badge/swift-4.0-green.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/EmptyPage.svg?style=flat)
![Version](https://img.shields.io/cocoapods/v/EmptyPage.svg?style=flat)
![CocoaPods](https://img.shields.io/badge/dep-CocoaPods-orange.svg)
![MIT](https://img.shields.io/badge/license-MIT-lightgray.svg)

# EmptyPage

##### 一套应用于swift项目的空白页.可利用预置的模板快速构建空白页视图.亦可高度自定义视图搭建炫酷的交互.

##### ps: oc项目可以使用[**DZNEmptyDataSet**](https://github.com/dzenbot/DZNEmptyDataSet)替代.

### 简介

app 显示列表内容时, 在某一时刻可能数据为空(等待网络请求/网络请求失败)等, 添加一个空白指示页将有效缓解用户可能造成的焦虑或混乱. 并可以帮助用户处理问题.

### Features

- [x] 支持UICollectionView & UITableView.

- [x] 支持链式配置预置模板视图.

- [x] 支持完全自定义视图.

- [ ] 支持更多实用与设计感的模板.


![demo](./imgs/empty1.gif) ![demo](./imgs/empty2.gif)  

### 预置模板视图(纯文字/纯图片/标准)
![only text](./imgs/demo0.png)![only image](./imgs/demo1.png)![standard](./imgs/demo2.png)

## Requirements

- Swift 4
- iOS 8+
- Xcode 10+

## 安装

- 使用cocoapods安装

  ##### 完全安装

  ```ruby
  pod 'EmptyPage'
  ```

  ##### 不需要预置模板安装

  ```ruby
  pod 'EmptyPage/Core'
  ```

## 使用

### 简单用法

##### In Swift:

- 配置空白页

  ```swift
  let emptyView = EmptyPageView.ContentView.standard
  	.change(hspace: .button, value: 80)
  	.change(height: .button, value: 60)
  	.change(hspace: .image, value: 15)
  	.config(button: { (item) in
  		item.backgroundColor = UIColor.blue
  		item.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
  	})
  	.set(image: UIImage(named: "empty-1002")!)
  	.set(title: "Connection failure", color: UIColor.black, font: UIFont.boldSystemFont(ofSize: 24))
  	.set(text: "Something has gone wrong with the internet connection. Let's give it another shot.", color: UIColor.black, font: UIFont.systemFont(ofSize: 15))
  	.set(buttonTitle: "TRY AGAIN")
  	.set(tap: {
  	// 点击事件
  	})
  	.mix()
  ```

- 设置空白页

  ```swift
  tableView.setEmpty(view: emptyView)
  collectionView.setEmpty(view: emptyView)
  ```

- 空白页显示与切换

  如果需要切换已显示的空白页可主动触发刷新.

  ```swift
  tableView.setEmpty(view: emptyView)
  tableView.reloadData()
  ```

### API

##### 由于jazzy bug, 仍在施工中...

## Author

linhay: is.linhay@outlook.com

## License

EmptyPage is available under the Apache License. See the LICENSE file for more info.
