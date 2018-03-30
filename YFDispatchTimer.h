//
//  YFDispatchTimer.h
//  
//
//  Created by Yvan on 2017/2/16.
//
//

#import <Foundation/Foundation.h>

@class YFDispatchQueue;
@interface YFDispatchTimer : NSObject

@property (nonatomic, strong, readonly) dispatch_source_t source;

#pragma mark - init
+ (instancetype)timer;
+ (instancetype)timerInQueue:(YFDispatchQueue *)queue;

#pragma mark - Methods
//使用默认时钟来进行计时。然而当系统休眠的时候，默认时钟是不走的，也就会导致计时器停止。
- (void)timerHandler:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)timerHandler:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)timerHandler:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
- (void)timerHandler:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
//按照真实时间间隔进行计时。
- (void)timerHandler:(dispatch_block_t)block wallTimeInterval:(uint64_t)interval;
- (void)timerHandler:(dispatch_block_t)block wallTimeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)timerHandler:(dispatch_block_t)block wallTimeIntervalWithSecs:(float)secs;
- (void)timerHandler:(dispatch_block_t)block wallTimeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
- (void)resume;
- (void)suspend;
- (void)cancel;

@end
