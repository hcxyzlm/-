//
//  ForwardMsg.m
//  消息转发机制
//
//  Created by zhuo on 2017/4/9.
//  Copyright © 2017年 zhuo. All rights reserved.
//

//

#import "ForwardMsg.h"
#import <objc/runtime.h>
#import "ReceiveObject.h"

@implementation ForwardMsg

// 动态方法解析，先进行这一步
+ (BOOL)resolveInstanceMethod:(SEL)name
// 实例方法
{
    
    NSLog(@" >> Instance resolving %@", NSStringFromSelector(name));
    // MissMethod为调用的方法名
    if (name == @selector(dynamicParserMethod)) {
        
        class_addMethod([self class], name, (IMP)dynamicMethodIMP, "v@:");
        
        return YES;
        
    }
    
    return [super resolveInstanceMethod:name];
    
}
// 处理该类无法处理消息的方法
void dynamicMethodIMP(id self, SEL _cmd) {
    
    NSLog(@" >> dynamicMethodIMP");
    
}

// 备援接收者的处理
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@" >> forwardingTargetForSelector %@", NSStringFromSelector(aSelector));
    
    if (aSelector == @selector(testReceiveObject)) {
        // 返回接受该方法的处理类
        ReceiveObject *receiveObject = [[ReceiveObject alloc] init];
        return receiveObject;
        
    }
    
    return [super forwardingTargetForSelector:aSelector];
}


/**
 *  消息派发系统通过此方法，将消息派发给目标对象,实现消息转发
 *
 *  @param anInvocation 之前创建的NSInvocation实例对象，用于装载有关消息的所有内容
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSLog(@"forwardInvocation = %@", NSStringFromSelector(anInvocation.selector));
    
    if (anInvocation.selector == @selector(forwardInvocationMsg)) {
        
        ReceiveObject *receiveObject = [[ReceiveObject alloc] init];
        if ([receiveObject respondsToSelector:[anInvocation selector]]) {
            [anInvocation invokeWithTarget:receiveObject];
        }else {
            [super forwardInvocation:anInvocation];
        }
    }
    
}

// 调用forwardInvocation之前要先进行对方法进行注册

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        // 注册
         ReceiveObject *receiveObject = [[ReceiveObject alloc] init];
        signature = [receiveObject methodSignatureForSelector:selector];
    }
    return signature;
}

@end
