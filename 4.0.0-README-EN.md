![title](https://s.linhey.com/emptypage-17.png)

![](https://img.shields.io/github/workflow/status/linhay/EmptyPage/build/master)
![](https://img.shields.io/cocoapods/v/EmptyPage.svg)
![](https://img.shields.io/cocoapods/l/EmptyPage.svg)
![](https://img.shields.io/cocoapods/p/EmptyPage.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flinhay%2FEmptyPage%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/linhay/EmptyPage)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flinhay%2FEmptyPage%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/linhay/EmptyPage)


## Feature

- [x] Provides a default manager to support UICollectionView & UITableView.
- [x] You can customize the manager to support any view.
- [x] Empty page can be any kind of view.
- [x] You can set a custom manager to replace the default manager.
- [x] A custom manager can be set to globally replace the default manager.
- [x] We preloaded several sets of templates to make it easy to build empty pages.
- [x] We have a pre-configured set of state managers for non-networking or more.



## Usage

Here is a simple example of binding a custom view to a UICollectionview:

````swift
let customEmptyView = CustomEmptyView()
collectionView.ep.set(emptyView: customEmptyView)
````

After the `UICollectionview` executes `reloadData()` , EmptyPage determines whether the data in the Datasource is empty, and then decides whether to display the empty view.



## Installation

### CocoaPods

If you use CocoaPods to manage your dependencies, simply add
UIFontComplete to your `Podfile`:

```ruby
pod 'EmptyPage'
```



### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Using Xcode 11.0+ go to your project file and enter the project URL of this repository:

```swift
https://github.com/linhay/EmptyPage
```



## Requirements

- iOS 9.0+
- Swift 4.0+



## Next Steps

We prepared a [wiki page](https://github.com/linhay/EmptyPage/wiki). You can find tons of useful things there.

* [Installation Guide](https://github.com/linhay/EmptyPage/wiki/Installation-Guide) - Follow it to integrate EmptyPage into your project.
* [Cheat Sheet](https://github.com/linhay/EmptyPage/wiki/Cheat-Sheet)- Curious about what EmptyPage could do and how would it look like when used in your project? See this page for useful code snippets. If you are already familiar with EmptyPage, you could also learn new tricks to improve the way you use EmptyPage!
* [API Reference](https://linhay.github.io/EmptyPage/) - Lastly, please remember to read the full whenever you may need a more detailed reference.



## Contact

Follow and contact me on [Twitter](https://twitter.com/islinhey) or [Sina Weibo](https://weibo.com/islinhey). If you find an issue, just [open a ticket](https://github.com/linhay/EmptyPage/issues/new). Pull requests are warmly welcome as well.



## License

EmptyPage is released under the Apache License 2.0 license. See [LICENSE](https://github.com/linhay/EmptyPage/blob/master/LICENSE) for details.

