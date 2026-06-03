//
//  ZKAppDelegateSOA.h
//  ZKAppDelegateSOA
//
//  Created by Kaiser on 2018/12/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// AppDelegate 子服务协议，需继承 `NSObject` 并实现 `UIApplicationDelegate` 方法。
@protocol ZKService <UIApplicationDelegate>

@end


/*!
 *  @code
 @interface ZKPushAppDelegateService : NSObject <ZKService> @end
 
 @implementation ZKPushAppDelegateService
 + (void)load {
    [[ZKAppDelegateSOA sharedInstance] registerServiceWithClass:self];
 }
 @end
 *  @endcode
 */
@interface ZKAppDelegateSOA : NSObject <UIApplicationDelegate>

+ (instancetype)sharedInstance;

- (NSArray<id<ZKService>> *)allServices;

- (void)registerServiceWithClass:(nonnull Class<ZKService>)cls NS_SWIFT_NAME(register(_:));

@end

NS_ASSUME_NONNULL_END
