//
//  NSObject+YFDDevLog.m
//  YFDDevCollector
//
//  Created by yaoyuan on 2020/11/30.
//

#import "NSObject+YFDDevLog.h"
#import <objc/runtime.h>

@implementation NSObject (YFDDevLog)

+ (void)tt_swizzleMethod:(SEL)originalSEL withMethod:(SEL)swizzleSEL {
    Method originalMethod = class_getInstanceMethod(self, originalSEL);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSEL);
    if (!originalMethod || !swizzleMethod) {
        return;
    }

    IMP originalIMP = method_getImplementation(originalMethod);
    if (class_addMethod(self, originalSEL, originalIMP, method_getTypeEncoding(originalMethod))) {
        originalMethod = class_getInstanceMethod(self, originalSEL);
    }

    IMP swizzleIMP = method_getImplementation(swizzleMethod);
    if (class_addMethod(self, swizzleSEL, swizzleIMP, method_getTypeEncoding(swizzleMethod))) {
        swizzleMethod = class_getInstanceMethod(self, swizzleSEL);
    }

    method_exchangeImplementations(originalMethod, swizzleMethod);
}

@end
