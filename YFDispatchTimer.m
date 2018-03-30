//
//  YFDispatchTimer.m
//  
//
//  Created by Yvan on 2017/2/16.
//
//

#import "YFDispatchTimer.h"
#import "YFDispatchQueue.h"

@interface YFDispatchTimer ()

@property (nonatomic, strong) dispatch_source_t source;

@end

@implementation YFDispatchTimer

#pragma mark - Init

+ (instancetype)timer {
    return [[self alloc] init];
}

+ (instancetype)timerInQueue:(YFDispatchQueue *)queue {
    return [[self alloc] initInQueue:queue];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    return self;
}

- (instancetype)initInQueue:(YFDispatchQueue *)queue {
    self = [super init];
    if (self) {
        self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.dispatchQueue);
    }
    return self;
}

#pragma mark - Methods
//系统时间
- (void)timerHandler:(dispatch_block_t)block timeInterval:(uint64_t)interval {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)timerHandler:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_time(DISPATCH_TIME_NOW, delay), interval, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)timerHandler:(dispatch_block_t)block timeIntervalWithSecs:(float)secs {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)timerHandler:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_time(DISPATCH_TIME_NOW, delaySecs * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.source, block);
}

//真实时间
- (void)timerHandler:(dispatch_block_t)block wallTimeInterval:(uint64_t)interval {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_walltime(NULL, 0), interval, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)timerHandler:(dispatch_block_t)block wallTimeInterval:(uint64_t)interval delay:(uint64_t)delay {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_walltime(NULL, delay), interval, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)timerHandler:(dispatch_block_t)block wallTimeIntervalWithSecs:(float)secs {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_walltime(NULL, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)timerHandler:(dispatch_block_t)block wallTimeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.source, dispatch_walltime(NULL, delaySecs * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.source, block);
}

- (void)resume {
    dispatch_resume(self.source);
}

- (void)suspend {
    dispatch_suspend(self.source);
}

- (void)cancel {
    dispatch_source_cancel(self.source);
}

@end
