![title](https://s.linhey.com/emptypage-17.png)

![](https://img.shields.io/github/workflow/status/linhay/EmptyPage/build/master)
![](https://img.shields.io/cocoapods/v/EmptyPage.svg)
![](https://img.shields.io/cocoapods/l/EmptyPage.svg)
![](https://img.shields.io/cocoapods/p/EmptyPage.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flinhay%2FEmptyPage%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/linhay/EmptyPage)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flinhay%2FEmptyPage%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/linhay/EmptyPage)

## 演示:

| ![](imgs/0.gif) | ![](imgs/1.gif) | ![](imgs/2.gif) |
| :---------------------------------------------: | :---------------------: | :---------------------: |
| **UICollectionView** | **UITableView** | **多状态切换** |

## 预置模板视图:

| ![](imgs/4.png) | ![](imgs/3.gif) | ![](imgs/7.png) | ![](imgs/5.png) | ![](imgs/6.png) |
| :--: | :--: | :--: | :--: | :--: |
| **静态图** | **动图** | **纯文本** | **富文本** | **复合型视图** |

## 特点:

- [x] 提供默认管理器来支持 UICollectionView & UITableView.
- [x] 可以自定义管理器来支持任何视图.
- [x] 空白页可以是任何形式的视图
- [x] 可以设置自定义的管理器来替代默认管理器
- [x] 可以设置自定义的管理器来全局替代默认管理器
- [x] 我们预置了几套模板来便捷的构建空页面.
- [x] 我们预置了一套[带状态的管理器](https://github.com/linhay/EmptyPage/wiki/Manager:-%5B%E5%8A%A0%E8%BD%BD-%E7%A9%BA%E6%95%B0%E6%8D%AE-%E6%97%A0%E7%BD%91%E7%BB%9C%5D%E7%AD%89%E5%A4%9A%E7%8A%B6%E6%80%81%E5%88%87%E6%8D%A2)来应对无网络或更多情况



## 使用

1. ##### 下面是一个简单的示例, 用来将一个空白页绑定在UICollectionView上:

   ```swift
   let customEmptyView = CustomEmptyView()
   collectionView.ep.set(emptyView: customEmptyView)
   ```

	空白页将在 `UICollectionView` 执行 `reloadData()`之后, 并判断数据源为空的情况下, 正确的出现在 `UICollectionView` 上.
	
2. ##### 使用预置模板快速创建空白页视图:

   <table style="margin-left: auto; margin-right: auto;">
        <tr>
            <td>
                <!--左侧内容-->
                <img src="imgs/6.png" style="zoom:100%;" />
            </td>
            <td>
                <!--右侧内容-->
                <img src="imgs/8.png" style="zoom:100%;" />
            </td>
        </tr>
   </table>

## 安装

### CocoaPods

1. 全量安装

   ```ruby
   pod 'EmptyPage'
   ```

2. 按需安装

   ```ruby
   pod 'EmptyPage/core'      # 核心库
   pod 'EmptyPage/managers'  # 拓展的管理器, 带状态的管理器就在其中
   pod 'EmptyPage/templates' # 预置的空白页模板
   ```

### Swift Package Manager

[ Swift Package Manager](https://Swift.org/Package-Manager) 是一个管理 Swift 代码分发的工具。它与 Swift 构建系统集成在一起，使下载、编译和链接依赖关系的过程自动化。

使用 Xcode 11.0 + 进入你的项目文件并输入这个存储库的项目 URL:

```swift
https://github.com/linhay/EmptyPage
```

## 更多

我们准备了一个 [wiki]( https://github.com/linhay/emptypage/wiki) 页面，可以在那里找到很多有用的示例与用法。
* [Manager: 加载/空数据/无网络等多状态切换](https://github.com/linhay/EmptyPage/wiki/Manager:-%5B%E5%8A%A0%E8%BD%BD-%E7%A9%BA%E6%95%B0%E6%8D%AE-%E6%97%A0%E7%BD%91%E7%BB%9C%5D%E7%AD%89%E5%A4%9A%E7%8A%B6%E6%80%81%E5%88%87%E6%8D%A2)

* [API 文档](https://linhay.github.io/EmptyPage/) - 最后，当你需要更详细的参考时，请记得阅读全文。

## 限制

- iOS 9.0+
- Swift 4.0+
- XCode 11.0+

## 联系

关注我并在[Twitter](https://Twitter.com/islinhey)或者[微博](https://Weibo.com/islinhey)上联系我。如果你发现一个问题，只要创建 [issues](https://github.com/linhay/emptypage/issues/new), 我们也期望你使用pull-requests来参与项目中来。

## 许可证

EmptyPage 是在 Apache License 2.0 许可下发布的。详细信息请参阅 [LICENSE](https://github.com/linhay/EmptyPage/blob/master/LICENSE)。

