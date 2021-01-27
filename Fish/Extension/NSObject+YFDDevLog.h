//
//  NSObject+YFDDevLog.h
//  YFDDevCollector
//
//  Created by yaoyuan on 2020/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YFDDevLog)

+ (void)tt_swizzleMethod:(SEL)originalSEL withMethod:(SEL)swizzleSEL;

@end

NS_ASSUME_NONNULL_END
