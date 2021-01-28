//
//  NSArray+Safe.h
//  Fish
//
//  Created by yaoyuan on 2021/1/27.
//  Copyright © 2021 Tutor. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Safe)

- (instancetype)safeInit:(id  _Nonnull const [])objects count:(NSUInteger)cnt;

@end

NS_ASSUME_NONNULL_END
