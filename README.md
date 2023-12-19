![title](https://s.linhey.com/emptypage-17.png)

![](https://img.shields.io/github/workflow/status/linhay/EmptyPage/build/master)
![](https://img.shields.io/cocoapods/v/EmptyPage.svg)
![](https://img.shields.io/cocoapods/l/EmptyPage.svg)
![](https://img.shields.io/cocoapods/p/EmptyPage.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flinhay%2FEmptyPage%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/linhay/EmptyPage)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flinhay%2FEmptyPage%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/linhay/EmptyPage)

## 演示:

| ![0](https://github.com/linhay/EmptyPage/assets/15262434/58addde2-62a7-4c7d-8850-92ff88f7733e) | ![1](https://github.com/linhay/EmptyPage/assets/15262434/06d85536-508f-4e55-a3e4-3cb599de7269) | ![2](https://github.com/linhay/EmptyPage/assets/15262434/fbb54109-6809-4323-a381-638755ed6e33) |
| :---------------------------------------------: | :---------------------: | :---------------------: |
| **UICollectionView** | **UITableView** | **多状态切换** |

## 预置模板视图:

| ![](https://github.com/linhay/EmptyPage/assets/15262434/de2de664-e2a5-4e1a-a290-df20bff5bd68) | ![](https://github.com/linhay/EmptyPage/assets/15262434/c1fabd31-b48e-437f-a63f-fd1295933c4e) | ![](https://github.com/linhay/EmptyPage/assets/15262434/fed4e247-86fe-4e71-bebd-12c108ed932a) | ![](https://github.com/linhay/EmptyPage/assets/15262434/f0f2cfa2-e35a-4676-9ff9-f47c30c1060f) | ![](https://github.com/linhay/EmptyPage/assets/15262434/5404caf4-42f8-451f-938f-cc503d176f46) |
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
                <img src="https://github.com/linhay/EmptyPage/assets/15262434/61a8ed38-8bce-424d-9901-9174bef8d02f" style="zoom:100%;" />
            </td>
            <td>
                <!--右侧内容-->
                <img src="https://github.com/linhay/EmptyPage/assets/15262434/f47e0e81-c5fd-4cee-909d-830b892a9106" style="zoom:100%;" />
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

