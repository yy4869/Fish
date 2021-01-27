//
//  UITableView+YFDDevLog.m
//  YFDDevCollector
//
//  Created by yaoyuan on 2020/11/30.
//

#import "UITableView+YFDDevLog.h"
#import "NSObject+YFDDevLog.h"
#import <objc/message.h>

@implementation UITableView (YFDDevLog)

+ (void)load {
    [UITableView tt_swizzleMethod:@selector(setDelegate:) withMethod:@selector(tutor_dev_setDelegate:)];
}

- (void)tutor_dev_setDelegate:(id<UITableViewDelegate>)delegate {
    [self tutor_dev_setDelegate:delegate];
    [self tutor_dev_swizzleDidSelectRowWithDelegate:delegate];
}

- (void)tutor_dev_swizzleDidSelectRowWithDelegate:(id)delegate {
    Class delegateClass = [delegate class];

    SEL originalSelector = @selector(tableView:didSelectRowAtIndexPath:);
    if (![delegate respondsToSelector:originalSelector]) {
        return;
    }

    NSString *swizzleSelectorString = [@"tutor_dev_" stringByAppendingFormat:@"%@", NSStringFromSelector(originalSelector)];
    SEL swizzleSelector = NSSelectorFromString(swizzleSelectorString);
    if ([delegate respondsToSelector:swizzleSelector]) {
        // 已经存在就直接返回
        return;
    }

    __weak __typeof(self) weakSelf = self;
    IMP newImplementation = imp_implementationWithBlock(^void(id sself, UITableView *tableView, NSIndexPath *indexPath) {
        ((void(*)(id, SEL, id, id))objc_msgSend)(sself, swizzleSelector, tableView, indexPath);

        [weakSelf testRetainCycle:[delegate description]];
    });

    Method originalMethod = class_getInstanceMethod(delegateClass, originalSelector);
    if (!class_addMethod(delegateClass, swizzleSelector, newImplementation, method_getTypeEncoding(originalMethod))) {
        return;
    }

    [delegateClass tt_swizzleMethod:originalSelector withMethod:swizzleSelector];
}

- (void)testRetainCycle:(NSString *)description {
    NSLog(@"test yy testRetainCycle %@", description);
}

@end
