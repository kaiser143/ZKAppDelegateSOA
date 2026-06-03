# ZKAppDelegateSOA

[![CI Status](https://img.shields.io/travis/zhangkai/ZKAppDelegateSOA.svg?style=flat)](https://travis-ci.org/zhangkai/ZKAppDelegateSOA)
[![Version](https://img.shields.io/cocoapods/v/ZKAppDelegateSOA.svg?style=flat)](https://cocoapods.org/pods/ZKAppDelegateSOA)
[![License](https://img.shields.io/cocoapods/l/ZKAppDelegateSOA.svg?style=flat)](https://cocoapods.org/pods/ZKAppDelegateSOA)
[![Platform](https://img.shields.io/cocoapods/p/ZKAppDelegateSOA.svg?style=flat)](https://cocoapods.org/pods/ZKAppDelegateSOA)

将 `AppDelegate` 按业务拆成多个子服务（SOA），通过消息转发统一调度 `UIApplicationDelegate` 回调。

## Requirements

- iOS 12.0+（库逻辑不变；12.0 为当前 Xcode 构建 Swift 模块所需）
- Objective-C 或 Swift 5.0+

## Installation

通过 [CocoaPods](https://cocoapods.org) 集成。Swift 工程建议使用 `use_frameworks!` 以便 `import ZKAppDelegateSOA`：

```ruby
platform :ios, '12.0'
use_frameworks!

target 'YourApp' do
  pod 'ZKAppDelegateSOA', :git => 'https://github.com/kaiser143/ZKAppDelegateSOA.git', :tag => '0.1.2'
end
```

## Objective-C 用法

### 1. 定义子服务

子服务需实现 `ZKService`（即 `UIApplicationDelegate`），并在 `+load` 中注册：

```objc
#import <ZKAppDelegateSOA/ZKAppDelegateSOA.h>

@interface ZKPushAppDelegateService : NSObject <ZKService>
@end

@implementation ZKPushAppDelegateService

+ (void)load {
    [[ZKAppDelegateSOA sharedInstance] registerServiceWithClass:self];
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 推送、统计等初始化
    return YES;
}

@end
```

### 2. 在 AppDelegate 中转发

在 `AppDelegate` 的生命周期方法里调用 `ZKAppDelegateSOA`，未实现的方法可通过 `forwardInvocation:` 转发（见 Example 工程）：

```objc
#import <ZKAppDelegateSOA/ZKAppDelegateSOA.h>

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[ZKAppDelegateSOA sharedInstance] application:application
                     didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (invocation.target == [ZKAppDelegateSOA sharedInstance]) {
        [[ZKAppDelegateSOA sharedInstance] forwardInvocation:invocation];
        return;
    }
    [super forwardInvocation:invocation];
}
```

## Swift 用法

### 1. 导入模块

```swift
import UIKit
import ZKAppDelegateSOA
```

无需手写 Bridging Header（CocoaPods + `use_frameworks!` 即可）。

### 2. 定义子服务

子服务必须继承 `NSObject` 并遵循 `ZKService`，且需加 `@objc` 以便运行时注册：

```swift
import UIKit
import ZKAppDelegateSOA

@objc(ZKPushAppDelegateService)
final class ZKPushAppDelegateService: NSObject, ZKService {

    // 等价于 ObjC 的 +load 注册
    private static let registerOnLoad = ZKAppDelegateSOARegistration.onLoad(ZKPushAppDelegateService.self)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        _ = Self.registerOnLoad
        return true
    }
}
```

也可在 `AppDelegate` 启动时手动注册：

```swift
ZKAppDelegateSOA.shared.register(ZKPushAppDelegateService.self)
```

### 3. 在 AppDelegate 中转发

`AppDelegate` 建议继承 `NSObject`（或 `UIResponder` + 显式 `@objc` 方法），在对应回调中交给 SOA：

```swift
import UIKit
import ZKAppDelegateSOA

@main
class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        _ = ZKAppDelegateSOA.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
}
```

其他 `UIApplicationDelegate` 方法同样在 `AppDelegate` 中显式调用 `ZKAppDelegateSOA.shared` 的对应方法，或通过 `forwardInvocation` 转发（与 Objective-C Example 相同）。

## API 对照

| Objective-C | Swift |
|-------------|-------|
| `[ZKAppDelegateSOA sharedInstance]` | `ZKAppDelegateSOA.shared` |
| `registerServiceWithClass:` | `register(_:)` |
| `allServices` | `allServices` |

## Example

克隆仓库后，在 `Example` 目录执行：

```bash
pod install
open ZKAppDelegateSOA.xcworkspace
```

- `ZKAppDelegate.m`：Objective-C 子服务与转发示例  
- `ZKSwiftPushAppDelegateService.swift`：Swift 子服务示例  

## Author

zhangkai, deyang143@126.com

## License

ZKAppDelegateSOA is available under the MIT license. See the LICENSE file for more info.
