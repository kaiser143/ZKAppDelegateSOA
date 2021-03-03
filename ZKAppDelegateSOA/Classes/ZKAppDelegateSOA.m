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
    dispatch_once(&onceToken, ^{ instance = [[[self class] alloc] init]; });
    return instance;
}

#pragma mark - Public methods

- (void)registerServiceWithClass:(Class)cls {
    if (!cls) return;

    [self addService:[cls new]];
}

#pragma mark - Private methods

- (void)addService:(id<ZKService>)service {
    if (![self.services containsObject:service]) { [self.services addObject:service]; }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([invocation.target conformsToProtocol:@protocol(UIApplicationDelegate)]) {
        for (id<ZKService> each in self.services) {
            if ([each respondsToSelector:invocation.selector]) {
                [invocation invokeWithTarget:each];
            }
        }
    } else {
        [super forwardInvocation:invocation];
    }
}

#pragma mark - getters and setters

- (NSMutableArray<id<ZKService>> *)services {
    if (!_services) { _services = @[].mutableCopy; }
    return _services;
}

- (NSArray<id<ZKService>> *)allServices {
    return self.services;
}

@end
