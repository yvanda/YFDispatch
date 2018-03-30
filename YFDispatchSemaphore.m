//
//  YFDispatchSemaphore.m
//  YvansKitDemo
//
//  Created by Yvan on 2017/2/16.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import "YFDispatchSemaphore.h"

@interface YFDispatchSemaphore ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation YFDispatchSemaphore

#pragma mark - init

+ (instancetype)semaphore {
    return [[self alloc] init];
}

+ (instancetype)semaphoreWithValue:(long)value {
    return [[self alloc] initWithValue:value];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (instancetype)initWithValue:(long)value {
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(value);
    }
    return self;
}

#pragma mark - Methods
- (BOOL)signal {
    return dispatch_semaphore_signal(self.semaphore) != 0;
}

- (void)wait {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delay {
    return dispatch_semaphore_wait(self.semaphore, dispatch_time(DISPATCH_TIME_NOW, delay)) == 0;
}

@end
