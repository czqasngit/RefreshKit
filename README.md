# RefreshKit

[![Version](https://img.shields.io/cocoapods/v/RefreshKit.svg?style=flat)](https://cocoapods.org/pods/RefreshKit)
[![License](https://img.shields.io/cocoapods/l/RefreshKit.svg?style=flat)](https://cocoapods.org/pods/RefreshKit)
[![Platform](https://img.shields.io/cocoapods/p/RefreshKit.svg?style=flat)](https://cocoapods.org/pods/RefreshKit)

## Introduce
A refresh kit for UIScrollView written by Swif
Pull-up pull-down kit
Simple to use and extend
## Feature
1.Default Header and Footer.
2.Animate Header(Gif, APNG).
3.Fast loading Footer refresh.
## Extension
1.Lottie
2.Custom Header and Footer
## Example
**More function please open Example/RefreshKit.xcworkspace**
### 1.Default Header and Footer
```
self.tableView.refresh.header = RefreshDefaultHeader.make {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.count = 10
                self.tableView.reloadData()
                self.tableView.refresh.header?.stopRefresh()
                self.tableView.refresh.footer?.resetNoMoreData()
            })
        }
        self.tableView.refresh.footer = RefreshDefaultFooter.make {
            if self.count >= 20 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.tableView.reloadData()
                    self.tableView.refresh.footer?.noMoreData()
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.count += 10
                    print("..............")
                    self.tableView.reloadData()
                    self.tableView.refresh.footer?.stopRefresh()
                })
            }
        }
```

### 2.Animate Header
```
self.tableView.refresh.header = RefreshAnimateHeader.make(path) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.count = 10
                self.tableView.reloadData()
                self.tableView.refresh.header?.stopRefresh()
                self.tableView.refresh.footer?.resetNoMoreData()
            })
        }
```
### 3. Fast Loading Footer
```
self.tableView.refresh.footer = RefreshFastFooter.makeFastFooter {
            if self.count >= 200 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.tableView.reloadData()
                    self.tableView.refresh.footer?.noMoreData()
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.count += 10
                    self.tableView.reloadData()
                    self.tableView.refresh.footer?.stopRefresh()
                })
            }
        }
```

## Requirements

## Installation

RefreshKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RefreshKit'
```

## Author

czqasngit, czqasn@163.com

## License

RefreshKit is available under the MIT license. See the LICENSE file for more info.


