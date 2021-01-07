//
//  ZKAppDelegateSOA.m
//  ZKAppDelegateSOA
//
//  Created by Kaiser on 2018/12/9.
//

#import "ZKAppDelegateSOA.h"

@interface ZKAppDelegateSOA ()

@property (nonatomic, strong, readwrite) NSMutableArray<id<ZKService>> *services;

@end

@implementation ZKAppDelegateSOA

+ (instancetype)sharedInstance {
    static ZKAppDelegateSOA *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

#pragma mark - State Transitions / Launch time:

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

#pragma mark - State Transitions / Transitioning to the foreground:

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each applicationDidBecomeActive:application];
        }
    }
}

#pragma mark - State Transitions / Transitioning to the foreground:

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each applicationDidEnterBackground:application];
        }
    }
}

#pragma mark - State Transitions / Transitioning to the inactive state:

// Called when leaving the foreground state.
- (void)applicationWillResignActive:(UIApplication *)application {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each applicationWillResignActive:application];
        }
    }
}

// Called when transitioning out of the background state.
- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each applicationWillEnterForeground:application];
        }
    }
}

#pragma mark - State Transitions / Termination:

- (void)applicationWillTerminate:(UIApplication *)application {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each applicationWillTerminate:application];
        }
    }
}

#pragma mark - Handling Remote Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
          fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

// Deprecated from iOS 10.0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

- (void)application:(UIApplication *)application
    handleActionWithIdentifier:(nullable NSString *)identifier
         forRemoteNotification:(NSDictionary *)userInfo
             completionHandler:(void (^)(void))completionHandler {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application
                handleActionWithIdentifier:identifier
                     forRemoteNotification:userInfo
                         completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application
    handleActionWithIdentifier:(nullable NSString *)identifier
         forRemoteNotification:(NSDictionary *)userInfo
              withResponseInfo:(NSDictionary *)responseInfo
             completionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(9.0)) {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application
                handleActionWithIdentifier:identifier
                     forRemoteNotification:userInfo
                          withResponseInfo:responseInfo
                         completionHandler:completionHandler];
        }
    }
}

// Deprecated from iOS 10.0
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didReceiveLocalNotification:notification];
        }
    }
}

- (void)application:(UIApplication *)application
    handleActionWithIdentifier:(nullable NSString *)identifier
          forLocalNotification:(UILocalNotification *)notification
             completionHandler:(void (^)(void))completionHandler {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application
                handleActionWithIdentifier:identifier
                      forLocalNotification:notification
                         completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application
    handleActionWithIdentifier:(nullable NSString *)identifier
          forLocalNotification:(UILocalNotification *)notification
              withResponseInfo:(NSDictionary *)responseInfo
             completionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(9.0)) {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application
                handleActionWithIdentifier:identifier
                      forLocalNotification:notification
                          withResponseInfo:responseInfo
                         completionHandler:completionHandler];
        }
    }
}

#pragma clang diagnostic pop

- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }
}

#pragma mark - Handling Continuing User Activity and Handling Quick Actions

- (BOOL)application:(UIApplication *)application
    willContinueUserActivityWithType:(NSString *)userActivityType {
    BOOL result = NO;
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            result = result || [each application:application willContinueUserActivityWithType:userActivityType];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application
    continueUserActivity:(NSUserActivity *)userActivity
      restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *__nullable restorableObjects))restorationHandler NS_AVAILABLE_IOS(8_0) {
    BOOL result = NO;
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            result = result || [each application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    BOOL result = NO;
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            result = result || [each application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = NO;
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            result = result || [each application:application handleOpenURL:url];
        }
    }
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = NO;
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            result = result || [each application:app openURL:url options:options];
        }
    }
    return result;
}

- (void)application:(UIApplication *)application
    didUpdateUserActivity:(NSUserActivity *)userActivity {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didUpdateUserActivity:userActivity];
        }
    }
}

- (void)application:(UIApplication *)application
    didFailToContinueUserActivityWithType:(NSString *)userActivityType
                                    error:(NSError *)error {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }
}

- (void)application:(UIApplication *)application
    performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
               completionHandler:(void (^)(BOOL succeeded))completionHandler API_AVAILABLE(ios(9.0)) {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    for (id<ZKService> each in self.services) {
        if ([each respondsToSelector:_cmd]) {
            [each application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }
}

#pragma mark - Public methods

- (void)registerServiceWithClass:(Class)cls {
    if (!cls) return;

    [self addService:[cls new]];
}

#pragma mark - Private methods

- (void)addService:(id<ZKService>)service {
    if (![self.services containsObject:service]) {
        [self.services addObject:service];
    }
}

#pragma mark - getters and setters

- (NSMutableArray<id<ZKService>> *)services {
    if (!_services) {
        _services = @[].mutableCopy;
    }
    return _services;
}

- (NSArray<id<ZKService>> *)allServices {
    return self.services;
}

@end
