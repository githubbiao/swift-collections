//
//  PHJProxy.h
//  demo
//
//  Created by apple on 2020/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///  用于处理 `timer` 循环引用，需要在  `target` `dealloc` 时，将 `timer` `invalid`
@interface WeakProxy : NSProxy

//通过创建对象
- (instancetype)initWithObjc:(id)object;

//通过类方法创建创建
+ (instancetype)proxyWithObjc:(id)object;

@end

NS_ASSUME_NONNULL_END
