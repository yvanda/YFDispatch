//
//  YFDispatchGroup.m
//  YvansKitDemo
//
//  Created by Yvan on 2017/2/16.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import "YFDispatchGroup.h"

@interface YFDispatchGroup ()

@property (nonatomic, strong) dispatch_group_t dispatchGroup;

@end

@implementation YFDispatchGroup

+ (instancetype)group {
    return [[self alloc] init];
}

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

#pragma mark - Methods
- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)time {
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, time)) == 0;
}

@end
