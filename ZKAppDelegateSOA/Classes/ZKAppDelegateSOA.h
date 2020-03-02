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


@interface ZKAppDelegateSOA : NSObject <UIApplicationDelegate>

+ (instancetype)sharedInstance;

- (NSArray<id<ZKService>> *)allServices;

- (void)registerServiceWithClass:(nonnull Class)cls;

@end

NS_ASSUME_NONNULL_END
