//
//  main.m
//  消息转发机制
//
//  Created by zhuo on 2017/4/9.
//  Copyright © 2017年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForwardMsg.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        ForwardMsg *forwardmsg = [[ForwardMsg alloc] init];
        // 测试动态解析
        [forwardmsg dynamicParserMethod];
        
        // 备援接收者的处理
        [forwardmsg testReceiveObject];
        
        // 消息转发最后一次机会
        [forwardmsg forwardInvocationMsg];
        
    }
    return 0;
}
