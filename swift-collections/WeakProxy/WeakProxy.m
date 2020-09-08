//
//  PHJProxy.m
//  demo
//
//  Created by apple on 2020/9/8.
//

#import "WeakProxy.h"

@interface WeakProxy ()

@property (nonatomic, weak) id object;

@end

@implementation WeakProxy

- (instancetype)initWithObjc:(id)object {
    self.object = object;
    return self;
}

+ (instancetype)proxyWithObjc:(id)object {
    return [[self alloc] initWithObjc:object];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([self.object respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.object];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.object methodSignatureForSelector:sel];
}

@end

