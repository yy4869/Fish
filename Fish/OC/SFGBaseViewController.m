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
    NSString *str = @"test";
    if (str.length == 5) {
        NSLog(@"true");
    } else {
        NSLog(@"false");
    }
    NSLog(@"test yy %@", str);
}

@end
