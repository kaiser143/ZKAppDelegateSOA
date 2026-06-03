import UIKit
import ZKAppDelegateSOA

/// Swift 子服务示例，行为与 Example 中的 `JPushAppDelegateService` 一致。
@objc(ZKSwiftPushAppDelegateService)
final class ZKSwiftPushAppDelegateService: NSObject, ZKService {

    private static let registerOnLoad = ZKAppDelegateSOARegistration.onLoad(ZKSwiftPushAppDelegateService.self)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        _ = Self.registerOnLoad
        NSLog("%@", NSStringFromSelector(#selector(application(_:didFinishLaunchingWithOptions:))))
        return true
    }
}
