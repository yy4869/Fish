//
//  NSArray+Safe.m
//  Fish
//
//  Created by yaoyuan on 2021/1/27.
//  Copyright © 2021 Tutor. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (instancetype)safeInit:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    id instance = nil;

    @try {
        instance = [self initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSAssert(NO, @"Crash on insert nil to array!");
        // TODO: 堆栈上报

        // 过滤nil, 重新初始化
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        for (int i = 0; i < cnt; i++) {
            if (objects[i]) {
                newObjects[index] = objects[i];
                index++;
            }
        }
        instance = [self initWithObjects:newObjects count:index];
    }
    @finally {
        return instance;
    }
}

@end
