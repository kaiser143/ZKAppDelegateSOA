import UIKit

public extension ZKAppDelegateSOA {

    /// Swift-friendly accessor for `sharedInstance`.
    static var shared: ZKAppDelegateSOA {
        sharedInstance()
    }
}

public enum ZKAppDelegateSOARegistration {

    /// Mirrors Objective-C `+load { [[ZKAppDelegateSOA sharedInstance] registerServiceWithClass:self]; }`.
    /// Assign the return value to a `static let` on the service type so registration runs before first use.
    @discardableResult
    public static func onLoad(_ type: ZKService.Type) -> Bool {
        ZKAppDelegateSOA.shared.register(type)
        return true
    }
}
