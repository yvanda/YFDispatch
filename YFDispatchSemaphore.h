//
//  YFDispatchSemaphore.h
//  YvansKitDemo
//
//  Created by Yvan on 2017/2/16.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDispatchSemaphore : NSObject

@property (nonatomic, strong, readonly) dispatch_semaphore_t semaphore;

#pragma mark - init
+ (instancetype)semaphore;
+ (instancetype)semaphoreWithValue:(long)value;

#pragma mark - Methods

/**
 通知信号，如果等待线程被唤醒则返回非0，否则返回0

 @return BOOL 判断是否非0
 */
- (BOOL)signal;//信号量+1

/**
 等待信号，可以设置超时参数。该函数返回0表示得到通知，非0表示超时。
 */
- (void)wait;//信号量-1
- (BOOL)wait:(int64_t)delay;

@end
