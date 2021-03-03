//
//  ZKAppDelegateSOA.h
//  ZKAppDelegateSOA
//
//  Created by Kaiser on 2018/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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

- (void)registerServiceWithClass:(nonnull Class<ZKService>)cls;

@end

NS_ASSUME_NONNULL_END
