//
//  YFDispatchQueue.m
//  YvansKitDemo
//
//  Created by Yvan on 2017/2/16.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import "YFDispatchQueue.h"
#import "YFDispatchGroup.h"

static YFDispatchQueue *mainQueue;
static YFDispatchQueue *defaultQueue;
static YFDispatchQueue *highPriorityQueue;
static YFDispatchQueue *lowPriorityQueue;
static YFDispatchQueue *backgroundQueue;

@interface YFDispatchQueue ()

@property (nonatomic, strong) dispatch_queue_t dispatchQueue;

@end

@implementation YFDispatchQueue

#pragma mark - Queue
+ (YFDispatchQueue *)mainQueue {
    return mainQueue;
}

+ (YFDispatchQueue *)defaultQueue {
    return defaultQueue;
}

+ (YFDispatchQueue *)highPriorityQueue {
    return highPriorityQueue;
}

+ (YFDispatchQueue *)lowPriorityQueue {
    return lowPriorityQueue;
}

+ (YFDispatchQueue *)backgroundQueue {
    return backgroundQueue;
}

#pragma mark - init
+ (void)initialize {
    if (self == [YFDispatchQueue self])  {
        mainQueue = [YFDispatchQueue new];
        defaultQueue = [YFDispatchQueue new];
        highPriorityQueue = [YFDispatchQueue new];
        lowPriorityQueue = [YFDispatchQueue new];
        backgroundQueue = [YFDispatchQueue new];
        
        mainQueue.dispatchQueue = dispatch_get_main_queue();
        defaultQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        highPriorityQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        lowPriorityQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        backgroundQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

+ (instancetype)serialQueue {
    return [[self alloc] initSerial];
}

+ (instancetype)serialQueueWithLabel:(NSString *)label {
    return [[self alloc] initSerialWithLabel:label];
}

+ (instancetype)concurrentQueue {
    return [[self alloc] initConcurrent];
}

+ (instancetype)concurrentQueueWithLabel:(NSString *)label {
    return [[self alloc] initConcurrentWithLabel:label];
}

#pragma mark - Private Initialized

- (instancetype)init {
    return [self initSerial];
}

- (instancetype)initSerial {
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initSerialWithLabel:(NSString *)label {
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (instancetype)initConcurrent {
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initConcurrentWithLabel:(NSString *)label {
    self = [super init];
    if (self) {
        self.dispatchQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark - Method
- (void)sync:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_sync(self.dispatchQueue, block);
}

- (void)async:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(self.dispatchQueue, block);
}

- (void)barrierSync:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_barrier_sync(self.dispatchQueue, block);
}

- (void)barrierAsync:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void)after:(dispatch_block_t)block delay:(NSTimeInterval)delay {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), self.dispatchQueue, block);
}

- (void)apply:(size_t)count block:(DISPATCH_NOESCAPE void(^)(size_t t))block {
    NSParameterAssert(block);
    dispatch_apply(count, self.dispatchQueue, block);
}

- (void)suspend {
    dispatch_suspend(self.dispatchQueue);
}

- (void)resume {
    dispatch_resume(self.dispatchQueue);
}

#pragma mark - Group Related
- (void)async:(dispatch_block_t)block inGroup:(YFDispatchGroup *)group {
    NSParameterAssert(block);
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

- (void)notify:(dispatch_block_t)block inGroup:(YFDispatchGroup *)group {
    NSParameterAssert(block);
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}

#pragma mark - Class Methods
+ (void)syncInMain:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_sync(mainQueue.dispatchQueue, block);
}

+ (void)asyncInMain:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(mainQueue.dispatchQueue, block);
}

+ (void)asyncInDefault:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(defaultQueue.dispatchQueue, block);
}

+ (void)asyncInHighPriority:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(highPriorityQueue.dispatchQueue, block);
}

+ (void)asyncInLowPriority:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(lowPriorityQueue.dispatchQueue, block);
}

+ (void)asyncInBackground:(dispatch_block_t)block {
    NSParameterAssert(block);
    dispatch_async(backgroundQueue.dispatchQueue, block);
}

+ (void)afterInMain:(dispatch_block_t)block delay:(NSTimeInterval)delay {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), mainQueue.dispatchQueue, block);
}

+ (void)afterInDefault:(dispatch_block_t)block delay:(NSTimeInterval)delay {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), defaultQueue.dispatchQueue, block);
}

+ (void)afterInHighPriority:(dispatch_block_t)block delay:(NSTimeInterval)delay {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), highPriorityQueue.dispatchQueue, block);
}

+ (void)afterInLowPriority:(dispatch_block_t)block delay:(NSTimeInterval)delay {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), lowPriorityQueue.dispatchQueue, block);
}

+ (void)afterInBackground:(dispatch_block_t)block delay:(NSTimeInterval)delay {
    NSParameterAssert(block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), backgroundQueue.dispatchQueue, block);
}

@end
