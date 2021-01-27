//
//  SFGBaseViewController.m
//  Tutor
//
//  Created by yuec on 2020/12/27.
//  Copyright © 2020 fenbi. All rights reserved.
//

#import "SFGBaseViewController.h"

@interface SFGBaseViewController ()

@end

@implementation SFGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = UIColor.redColor;
    self.title = @"test";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


@end
