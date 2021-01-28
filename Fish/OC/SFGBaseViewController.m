//
//  SFGBaseViewController.m
//  Tutor
//
//  Created by yuec on 2020/12/27.
//  Copyright © 2020 fenbi. All rights reserved.
//

#import "SFGBaseViewController.h"
#import "WCMacroSafeValue.h"

@interface SFGBaseViewController ()

@end

@implementation SFGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.5];
    self.title = @"test";
    [self setupData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setupData {
    NSString *nilStr;
    NSArray *array = SafeArray(@"0", @"1", nilStr, @"3", nilStr);
    NSArray *array2 = SafeArray(@[@"00"], SafeArray(nilStr), @[@"10", @"11"]);

    NSLog(@"array: %@", array);
    NSLog(@"array2: %@", array2);

    NSDictionary *dic2 = SafeDictLiteral(@{
        @"key": @"value",
        nilStr: @"value",
        @"key2": nilStr,
        @"key3": @"value"
    });
    NSLog(@"dict: %@", dic2);

    NSDictionary *dict4 = SafeDict(
                                   SafeDictPair(@"key1", @"value1");
                                   SafeDictPair(nilStr, @"value");
                                   SafeDictPair(@"key", nilStr);
                                   SafeDictPair(nilStr, nilStr);
                                   SafeDictPair(@"key2", @"value2");
                                   );

    NSLog(@"dict4: %@", dict4);
    
}

@end

@implementation NSArraySafeLiteral

+ (NSArray *)arrayWithObjects:(id)terminator, ... {
    NSParameterAssert(terminator != nil);

    NSMutableArray *result = [NSMutableArray new];

    va_list args;
    va_start(args, terminator);

    id _Nullable nextObject = va_arg(args, id);

    while (nextObject != terminator) {
        if (nextObject != nil) {
          [result addObject: nextObject];
        }
        nextObject = va_arg(args, id);
    }

    va_end(args);

    return result;
}

@end
