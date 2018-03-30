//
//  YFDispatchGroup.h
//  YvansKitDemo
//
//  Created by Yvan on 2017/2/16.
//  Copyright © 2017年 Yvan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDispatchGroup : NSObject

@property (nonatomic, strong, readonly) dispatch_group_t dispatchGroup;

+ (instancetype)group;

#pragma mark - init
- (instancetype)init;

#pragma mark - Methods

/**
 手动管理group关联的block的运行状态（或计数），进入和退出group次数必须匹配
 */
- (void)enter;
- (void)leave;

/**
 等待group关联的block执行完毕，也可以设置超时参数
 */
- (void)wait;
- (BOOL)wait:(int64_t)time;

@end
