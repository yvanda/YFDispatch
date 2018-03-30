//
//  YFDispatchQueue.h
//  YvansKitDemo
//
//  Created by Yvan on 2017/2/16.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YFDispatchGroup;
@interface YFDispatchQueue : NSObject

@property (nonatomic, strong, readonly) dispatch_queue_t dispatchQueue;

#pragma mark - System Queue
+ (YFDispatchQueue *)mainQueue;
+ (YFDispatchQueue *)defaultQueue;
+ (YFDispatchQueue *)highPriorityQueue;
+ (YFDispatchQueue *)lowPriorityQueue;
+ (YFDispatchQueue *)backgroundQueue;

#pragma mark - Class Methods
+ (void)asyncInMain:(dispatch_block_t)block;
+ (void)asyncInDefault:(dispatch_block_t)block;
+ (void)asyncInHighPriority:(dispatch_block_t)block;
+ (void)asyncInLowPriority:(dispatch_block_t)block;
+ (void)asyncInBackground:(dispatch_block_t)block;

+ (void)afterInMain:(dispatch_block_t)block delay:(NSTimeInterval)delay;
+ (void)afterInDefault:(dispatch_block_t)block delay:(NSTimeInterval)delay;
+ (void)afterInHighPriority:(dispatch_block_t)block delay:(NSTimeInterval)delay;
+ (void)afterInLowPriority:(dispatch_block_t)block delay:(NSTimeInterval)delay;
+ (void)afterInBackground:(dispatch_block_t)block delay:(NSTimeInterval)delay;

//放在主线程下会阻塞，建议放到全局队列中
+ (void)syncInMain:(dispatch_block_t)block;

#pragma mark - init (Custom Queue)

+ (instancetype)serialQueue;
+ (instancetype)serialQueueWithLabel:(NSString *)label;
+ (instancetype)concurrentQueue;
+ (instancetype)concurrentQueueWithLabel:(NSString *)label;

#pragma mark - Method
- (void)sync:(dispatch_block_t)block;
- (void)async:(dispatch_block_t)block;
- (void)barrierSync:(dispatch_block_t)block;
- (void)barrierAsync:(dispatch_block_t)block;
- (void)after:(dispatch_block_t)block delay:(NSTimeInterval)delay;
- (void)apply:(size_t)count block:(DISPATCH_NOESCAPE void(^)(size_t t))block;
- (void)suspend;
- (void)resume;

#pragma mark - Group Related
- (void)async:(dispatch_block_t)block inGroup:(YFDispatchGroup *)group;
- (void)notify:(dispatch_block_t)block inGroup:(YFDispatchGroup *)group;

@end
