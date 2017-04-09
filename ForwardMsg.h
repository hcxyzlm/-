//
//  ForwardMsg.h
//  消息转发机制
//
//  Created by zhuo on 2017/4/9.
//  Copyright © 2017年 zhuo. All rights reserved.
//

// 消息转发处理类

#import <Foundation/Foundation.h>

@interface ForwardMsg : NSObject

- (void)dynamicParserMethod;

// 这个方法会转发为ReceiveObject类去处理
- (void)testReceiveObject;

// 这个方法会进入消息转发，可以最后一个机会处理
- (void)forwardInvocationMsg;

@end
